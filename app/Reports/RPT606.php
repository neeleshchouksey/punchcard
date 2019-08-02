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

class RPT606 extends ReportDataAbstract
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
        // $authUser = (new ClientsAccess($viewingUser))->getAsType();
        // $clients  = new ClientsPermittedToAccess(new Request, $authUser);

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
            'Race',
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
        
        $American_indian_alaskan_native = 0;
        $asian = 0;
        $black_or = 0;
        $native_hawaiian = 0;
        $hispanic_or_latino = 0;
        $white = 0;
        $two_or_more_races = 0;
        $other = 0;
        foreach ($users as $user) {

            $jdoc = json_decode($user->jdoc);

            if($jdoc->demographics->ethnicity == "American_Indian/Alaskan_Native"){
                
                $American_indian_alaskan_native++; 
            }
            if($jdoc->demographics->ethnicity == "Asian"){
                $asian++; 
            }
            if($jdoc->demographics->ethnicity == "Black_or_African_American"){
                $black_or++; 
            }
            if($jdoc->demographics->ethnicity == "Native_Hawaiian_or_Other_Pacific_Islander"){
                $native_hawaiian++; 
            }
            if($jdoc->demographics->ethnicity == "Hispanic_or_Latino"){
                $hispanic_or_latino++; 
            }
            if($jdoc->demographics->ethnicity == "White"){
                $white++; 
            }
            if($jdoc->demographics->ethnicity == "Two_or_More_Races"){
                $two_or_more_races++; 
            }
            if($jdoc->demographics->ethnicity == "Other"){
                $other++; 
            }     
            
        }

        $rows = array(0=>["American Indian/Alaskan Native",$American_indian_alaskan_native], 1 => ["Asian",$asian], 2 => ["Black or African American", $black_or], 3 => ["Native Hawaiian or Other Pacific Islander", $native_hawaiian], 4 => ["Hispanic or Latino",$hispanic_or_latino], 5 => ["White", $white], 6 => ["Two or More Races", $two_or_more_races], 7 => ['Other', $other]);
        
        return $rows;
    }
}
