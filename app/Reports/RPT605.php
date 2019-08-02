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

class RPT605 extends ReportDataAbstract
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
            'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
                                   ->getManyClients(false),
            'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjectsForReports(),
        ];
    }


    protected function getColumns()
    {
        return [
            'Comapny',
            'Male',
            'Female',
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
        
        
        $rows = [];

        $results = array();
        foreach ($users as $user) {
            $results[$user->client_id][] = $user;
        }

        foreach ($results as $result) {
               
               $female = 0;
               $male = 0;

            foreach($result as $userData){
               $jdoc = json_decode($userData->jdoc);
               
                if($jdoc->demographics->sex == "female"){
                    
                    $female++; 
                }
                if($jdoc->demographics->sex == "male"){
                    $male++; 
                }
                $clients  = Client::where('id', $userData->client_id)->first();      
                $companyName = $clients->name;

            } 
            
            $rows[] = [
                $companyName,
                $male,
                $female
            ];

        }
        $total_male = 0;
        $total_female = 0;

        foreach($rows as $row){
            
            $total_male = $total_male + $row[1];
            $total_female = $total_female + $row[2];
        }

        array_push($rows, array('Total', $total_male, $total_female));

           
        
        return $rows;
    }
}
