<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use Auth;
use App\User;
use App\ProjectFull;
use App\ProjectLogo;
use App\ProjectsAccessUser;
use App\ProjectsUserPermittedToAccess;
use App\UserLog;
use App\Check;
use App\CheckStatsData;
use App\CheckStats;

class ProjectsController extends ApiController
{
    public function index(Request $request, $uniq_id = null)
    {
        if ($uniq_id) {
            return $this->returnOneProject($uniq_id);
        }

        $projectsAccessUser = new ProjectsAccessUser(Auth::user());

        $projects = new ProjectsUserPermittedToAccess(
            $request,
            $projectsAccessUser->getAsType()
        );

        $getUser =  Auth::user();

        // For role user only by palash 26/02/18

        if($getUser->role == 'user'){

            return $this->respondWithJsonPagination(
            $projects->getManyProjects()
            );
        
        }

         // For role user only by palash 26/02/18

        
        $clientData = $projects->getManyProjects()->toArray();

            $newProData = array();

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



        return $this->respondWithJsonPaginationForClients($clientData);
    }

    // GET
    public function logs($uniq_id)
    {
        $project = ProjectFull::where('uniq_id', $uniq_id)->first(['id']);

        $logs = UserLog::where('user_id', Auth::user()->id)
            ->where('project_id', $project->id)
            ->orderBy('dateTime', 'DESC')
            ->paginate(10);

        $logs->load('project');

        $logs->map(function ($item, $key) {
            unset($item->id);
            unset($item->user_id);
            unset($item->project_id);

            return $item;
        });

        return $this->respondWithJsonPagination($logs);
    }

    public function employees(Requests\ProjectsUniqIdEmployeesRequest $request, $uniq_id)
    {
        $project = ProjectFull::where('uniq_id', $uniq_id)->first(['id']);
        $users   = $project->usersListForMobile;

        foreach ($users as $user) {
            $user->addOnsite($project->id);
            $user->addLastChecks($project->id);
        }

        $num     = sizeof($users);
        return $this->jsonSuccess("Retrieved {$num} records", $users);
    }

    public function logo($uniq_id)
    {
        $logo = new ProjectLogo($uniq_id);
        return $logo->handle();
    }


    public function onsite($uniq_id)
    {
        $project = ProjectFull::where('uniq_id', $uniq_id)->first(['id']);
        $onsite  = $project->onSite();
        $num     = sizeof($onsite);

        return $this->jsonSuccess("Retrieved {$num} records", $onsite);
    }

    protected function returnOneProject($uniq_id)
    {
        $project = ProjectFull::where('uniq_id', $uniq_id)->first(
            [
                'projects.id',
                'projects.client_id', // needed for logo!
                'projects.name',
                'projects.uniq_id',
                'projects.description',
                'startDate',
                'endDate',
                'latitude',
                'longitude',
                'radius',
            ]
        );

        $num = sizeof($project);
        return $this->jsonSuccess("Retrieved {$num} records", $project);
    }
}
