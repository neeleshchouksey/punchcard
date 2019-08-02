<?php namespace App\Reports;

use DB;
use Auth;
use App\User;
use App\Client;
use App\ClientProject;
use App\Project;
use App\Check;
use App\CheckStatsData;
use \Carbon\Carbon;
use Illuminate\Http\Request; // faking it
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;

class RPT603 extends ReportDataAbstract
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
    // Option Data for 606:
    //  - Only projects & date options
    //
    public function gatherOptionData($viewingUser)
    {
        $authUser = (new ClientsAccess($viewingUser))->getAsType();
        $clients  = new ClientsPermittedToAccess(new Request, $authUser);

        $authProject = (new ProjectsAccess($viewingUser))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);
        

        return [
            // 'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
            //                        ->getManyClients(false),
            'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjectsForReports(),
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

        // $client  = Client::where('uniq_id', $this->inData['client']['value'])->first();
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
        
        foreach ($jdoc_array as $element) {
            
            $result[$element->jdoc->vehicle->driversLicenseState][] = $element;
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


        // $users  = DB::select("SELECT COUNT(id), jdoc->'vehicle'->>'driversLicenseState' as state FROM users where client_id = $client->id AND jdoc->'vehicle'->>'driversLicenseState' != '' AND created_at BETWEEN '$startDate' AND '$endDate' GROUP BY state;");
        
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
