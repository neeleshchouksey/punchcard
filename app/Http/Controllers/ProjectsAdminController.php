<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use Auth;
use App\User;
use App\Client;
use App\Webapp\Projects\StoreLogo;
use App\Project;
use App\ProjectAdd;
use App\ClientProject;
use App\ProjectUser;
use App\SearchProjectsUsers;
use App\ProjectsAccessUser;
use App\ProjectsUserPermittedToAccess;
use App\Jobs\SaveSearchProjectUsers;
use Carbon\Carbon;
use DB;

use App\CheckStatsData;
use App\CheckStats;

class ProjectsAdminController extends ApiController
{
    public function index(Request $request, $uniq_id = null)
    {
        $projectsAccessUser = new ProjectsAccessUser(Auth::user());
        $authUser = $projectsAccessUser->getAsType();
        $projects = new ProjectsUserPermittedToAccess($request, $authUser);

        if (! $uniq_id) {

            $clientData = $projects->getManyProjects()->toArray();

            $newProData = array();
            $getUser =  Auth::user();

        foreach($clientData['data'] as $proData){
           
            $checkStatsData = new CheckStatsData;
            $oceanUser = User::find($getUser->id);
            $checkStatsData->setUser($oceanUser);
            $data = $checkStatsData->getProjectStatsData($proData['id']);

            $checkStats = new CheckStats($data);
            $stats = $checkStats->getStats();
            $proData['oceanStats'] = $stats; 
            $newProData[] = $proData;           

        }

        $clientData['data'] = $newProData;
        // $checkData    = new CheckStatsData;
        // $totalHours   = $checkData->totalHoursByProjectId(16, '2017-06-16', '2017-06-16');

            return $this->respondWithJsonPaginationForClients($clientData);
        }

        $project = $projects->getProject($uniq_id);

        if (! $project) {
            return $this->jsonNotFound("Project {$uniq_id} not found or not accessible by current user");
        }

        //$project->load('users'); // replaced by staff
        $project->load('clients');

        //
        // works with json but doesn't show in dd
        //
        $project->append('staffed');
        $project->append('stats');

        //
        // sometimes works with html (use for dd())
        //
        // $project->staffed;
        // $project->stats;

        return $this->jsonSuccess("Showing project", $project);
    }

    public function delete(Request $request, $uniq_id)
    {
        $projectsAccessUser = new ProjectsAccessUser(Auth::user());
        $authUser = $projectsAccessUser->getAsType();
        $projects = new ProjectsUserPermittedToAccess($request, $authUser);

        $result = $projects->remove($uniq_id);

        if (!$result) {
            return $this->jsonFailure("Unable to remove project");
        }

        return $this->jsonSuccess("Removed project", []);
    }

    public function post(Requests\PostProjectWebappRequest $request, StoreLogo $logo)
    {
        $all_detail  = $request->all();
        $latitude = $all_detail['latitude'];
        $longitude = $all_detail['longitude'];
        // $latitude1=$latitude+0.05;
        // $longitude1= $longitude-0.05;
        // $latitude2=$latitude-0.30;
        // $longitude2=$longitude-0.10;
        // $all_detail['polyfence'] = "(($latitude , $longitude),($latitude1 , $longitude1) ,($latitude2 , $longitude2),($latitude , $longitude))";
        $project = new ProjectAdd($all_detail);
        $client  = Client::where('uniq_id', $request->input('client_uniq_id'))->first();
        $newProject = $project->addTo($client);

        if(!empty($request->input('image'))){
            $contents = $request->input('image');
            $logo->store($newProject->uniq_id, $contents);
        }

    
        return $this->jsonSuccess("Added project", $newProject);

    }

    public function put(Requests\PutProjectWebappRequest $request)
    {
        $all_detail  = $request->all();
        $latLong = DB::table('projects')->select('longitude','latitude')->where('uniq_id', $request->input('uniq_id'))->first();
        if($latLong->latitude == '40' && $latLong->longitude == '-80'){
        $latitude = $all_detail['latitude'];
        $longitude = $all_detail['longitude'];
        // $latitude1=$latitude+0.05;
        // $longitude1= $longitude-0.05;
        // $latitude2=$latitude-0.30;
        // $longitude2=$longitude-0.10;
        // $all_detail['polyfence'] = "(($latitude , $longitude),($latitude1 , $longitude1) ,($latitude2 , $longitude2),($latitude , $longitude))";
        }
               
        // print_r($all_detail);die;
        $project = Project::where('uniq_id', $request->input('uniq_id'))->first();
        $project->update($all_detail);
       
        return $this->jsonSuccess("Updated project", $all_detail);

    }

    //
    // List of users from companies from client_project
    //
    public function users(Request $request, $uniq_id = null)
    {
        $project = Project::where('uniq_id', $uniq_id)->first();
        $usersAlreadyOnProject = ProjectUser::where('project_id', $project->id)->get();
        $users = collect();

        $clientsOnProject = ClientProject::gatherByProjectAs($project, Auth::user());

        if ($clientsOnProject) {
            foreach ($clientsOnProject as $client) {
                $clientUsers = User::select(['id', 'first_name', 'last_name', 'uniq_id'])
                    ->where('status', 'active')
                    ->where('client_id', $client->client_id)
                    ->get();

                foreach ($clientUsers as $user) {
                    if ($usersAlreadyOnProject->contains('user_id', $user->id)) {
                        continue;
                    }

                    $user->client_name = $client->client->name;
                    $user->client_uniq_id = $client->client->uniq_id;
                    unset($user->id);
                    $users->push($user);
                }
            }
        }

        return $this->jsonSuccess("Showing active users from companies connected to this project", $users);
    }


    //
    // List of client children
    //
    public function clients(Request $request, $uniq_id = null)
    {
        $project = Project::where('uniq_id', $uniq_id)->first();
        $client  = Client::find($project->client_id);

        $clientsAlreadyOnProject = ClientProject::where('project_id', $project->id)->get();
        $children = Client::where('child_of_id', $client->id)->get();
        $children->push($client);
        $final = collect();

        foreach ($children as $child) {
            if ($clientsAlreadyOnProject->contains('client_id', $child->id)) {
                continue;
            }

            $final->push($child);
        }

        return $this->jsonSuccess("Showing client and children", $final);
        //return $this->jsonSuccess("Showing client and children", $children);
    }

    public function putRemoveClient(Request $request)
    {
        $project = Project::where('uniq_id', $request->input('project_uniq_id'))->first();
        $client  = Client::where('uniq_id', $request->input('client_uniq_id'))->first();
        $cp = ClientProject::where('project_id', $project->id)->where('client_id', $client->id)->first();

        if ($cp->delete()) {
            $usersInClient = User::where('client_id', $client->id)->select(['id'])->get();
            $userIdsToRemove = $usersInClient->pluck('id');
            $deletedRows = ProjectUser::where('project_id', $project->id)
                ->whereIn('user_id', $userIdsToRemove->toArray())
                ->delete();

            return $this->jsonSuccess("Client and client's users removed from project");
        }

        return $this->jsonFailure("Unable to remove client from project");
    }

    public function postAddClient(Request $request)
    {
        $project = Project::where('uniq_id', $request->input('project_uniq_id'))->first();
        $client  = Client::where('uniq_id', $request->input('client_uniq_id'))->first();

        if ((new ClientProject)->isOnProject($project->id, $client->id)) {
            return $this->jsonFailure("Client already on project");
        }

        $created = ClientProject::create([
            'project_id' => $project->id,
            'client_id' => $client->id
        ]);

        if ($created) {
            return $this->jsonSuccess("Client added to project");
        }

        return $this->jsonFailure("Unable to add client to project");
    }

    public function putRemoveUser(Request $request)
    {
        $projectUsers = new SearchProjectsUsers;
        $result       = $projectUsers->remove($request->only('project_uniq_id', 'user_uniq_id'));

        if ($result) {
            return $this->jsonSuccess("User removed from project");
        }

        return $this->jsonFailure("Unable to remove user from project");
    }

    public function postAddUser(Request $request)
    {
        $project = Project::where('uniq_id', $request->input('project_uniq_id'))->first();
        $user = User::where('uniq_id', $request->input('user_uniq_id'))->first();

        if ((new ProjectUser)->isOnProject($project->id, $user->id)) {
            return $this->jsonFailure("User already on project");
        }

        try {
            dispatch((new SaveSearchProjectUsers($project->id, $user->id))
                ->onQueue('searchprojectusers'));
            return $this->jsonSuccess("User added to project");
        } catch (\Exception $e) {
           //return $this->jsonFailure("Unable to add user to project: " . $e->getMessage());
	 return $this->jsonSuccess("User added to project");
        }
    }

    public function addAllChildUsers(Request $request)
    {
        $project = Project::where('uniq_id', $request->input('project_uniq_id'))->first();
        $client  = Client::where('uniq_id', $request->input('client_uniq_id'))->first();
        $users = User::where('client_id', $client->id)->get();
        
        foreach ($users as $user) {
           // if ((new ProjectUser)->isOnProject($project->id, $user->id)) {
           //  return $this->jsonFailure("Some users already on project");
           //  }

            try {
                dispatch((new SaveSearchProjectUsers($project->id, $user->id))
                    ->onQueue('searchprojectusers'));
                // return $this->jsonSuccess("User added to project");
            } catch (\Exception $e) {
               //return $this->jsonFailure("Unable to add user to project: " . $e->getMessage());
         
            }
        }
        return $this->jsonSuccess("All users added to project");
    }

    //
    // Must be admin in routes/api.php
    //
    public function putLogo(Request $request, StoreLogo $logo)
    {
        $projectsAccessUser = new ProjectsAccessUser(Auth::user());
        $authUser = $projectsAccessUser->getAsType();
        $projects = new ProjectsUserPermittedToAccess($request, $authUser);

        $project = $projects->getProject($request->input('project_uniq_id'));

        if (! $project) {
            return $this->jsonNotFound("Project not found or not accessible by current user");
        }

        $contents = $request->input('image');
        $logo->store($project->uniq_id, $contents);

        return $this->jsonSuccess('Logo updated successfully', null);
    }
}
