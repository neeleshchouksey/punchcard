<?php namespace App\Reports;

use Auth;

use App\Project;
use App\Client;
use App\Check;
use DB;
use Illuminate\Http\Request; // faking it
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT601 extends ReportDataAbstract
{
    protected $inData;

    public function __construct()
    {
        parent::__construct();
    }

    public function gather($inData)
    {
        $this->inData = $inData;

        $ret = new \StdClass;
        $ret->columns = $this->getColumns();
        $ret->inData = $inData;
        $ret->meta = $this->getMeta();
        $ret->rows = $this->getRows();

        return $ret;
    }

    //
    // Option Data for 403:
    //  - list of projects the current user can see
    //  - list of users on each of those projects, filtered when they change projects
    //
    public function gatherOptionData($viewingUser)
    {
        // $authUser = (new ClientsAccess($viewingUser))->getAsType();
        // $clients  = new ClientsPermittedToAccess(new Request, $authUser);

        $authProject = (new ProjectsAccess($viewingUser))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);

        return [
            'address'    => array(0 =>['name'=>'Primary Address','uniq_id'=> 1],1 => ['name'=>'Secondry Address', 'uniq_id'=> 2]),
            // 'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
            //                        ->getManyClients(false),
            'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjects(false),
        ];
    }

    protected function getColumns()
    {
        return [
            'State',
            'Number of Employee',
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }


        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $users   = DB::table('project_user')->join('users', 'project_user.user_id', '=', 'users.id')
                                                 ->where('project_id', $project->id)
                                                 // ->where('users.client_id', $client->id)
                                                 ->whereBetween('users.created_at', [$this->inData['startDate'], $this->inData['endDate']])
                                                 ->get();


        $jdoc_array = array();
        foreach ($users as $user) {

            $jdoc = json_decode($user->jdoc);

            $user->jdoc = $jdoc;
           
            $jdoc_array[] = $user;
        }

        $result = array();

        if($this->inData['address']['value'] == 1){

            $address = 'primaryAddress';
        
            foreach ($jdoc_array as $element) {
                
                $result[$element->jdoc->primaryAddress->state][] = $element;
            }

        }else{
            $address = 'secondaryAddress';
            foreach ($jdoc_array as $element) {
                
                $result[$element->jdoc->secondaryAddress->state][] = $element;
            }
        }


        $rows = [];

        foreach($result as $key => $value){ 
        
            if(!empty($key)){
            $rows[] = [
                $key,
                count($value),
            ];
        }
    }

        return $rows;

        

        // $startDate = $this->inData['startDate'];
        // $endDate = $this->inData['endDate'];

        // if($this->inData['address']['value'] == 1){
        //     $users  = DB::select("SELECT COUNT(id), jdoc->'primaryAddress'->>'state' as state FROM users where client_id = $client->id AND jdoc->'primaryAddress'->>'state' != ''  AND created_at BETWEEN '$startDate' AND '$endDate' GROUP BY state;");
        // }else{
        //     $users  = DB::select("SELECT COUNT(id), jdoc->'secondaryAddress'->>'state' as state FROM users where client_id = $client->id AND jdoc->'secondaryAddress'->>'state' != ''  AND created_at BETWEEN '$startDate' AND '$endDate' GROUP BY state;");
        // }


        
        
        // $rows = [];

        // foreach ($users as $user) {
           
        //     $rows[] = [
        //         $user->state,
        //         $user->count,
        //     ];
        // }
        
        // return $rows;

}

    
}
