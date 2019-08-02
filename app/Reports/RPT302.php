<?php namespace App\Reports;

use DB;
use Auth;
use App\Client;
use App\User;
use App\Project;
use App\Check;
use App\CheckStatsData;
use \Carbon\Carbon;
use Illuminate\Http\Request; // faking it
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;

class RPT302 extends ReportDataAbstract
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
    // Option Data for 302
    //  - list of projects they have access to
    //  - date options
    //
    public function gatherOptionData($viewingUser)
    {
        $authProject = (new ProjectsAccess($viewingUser))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);

        return [
            'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjects(false),
        ];
    }

    protected function getColumns()
    {
        return [
            'Employee Name',
            'Employee #',
            'Company Name',
            'Clocked In',
            'Time Sheet'
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $authProject = (new ProjectsAccess(Auth::user()))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);
        $project     = $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                ->getProject($this->inData['project']['value']);

        $staffed = $project->staffed;


        $project_id = $project->id;
        
        $punch = DB::table('checks') 
            ->join('users', 'users.id', '=', 'checks.user_id')
            ->join('clients', 'clients.id', '=', 'users.client_id')
            ->select('checks.*','users.first_name','users.last_name', 'users.uniq_id as userUniq', 'clients.name')
            ->where('checkOutDateTime','=',NULL)
            ->where('users.deleted_at','=',NULL)
            ->where('project_id','=',$project_id)
            ->get();
    
        $rows = [];
        foreach ($punch as $punchs) {
        
           if(count($punchs) > 0){

            $rows[] = [
                $punchs->first_name.' '.$punchs->last_name,
                $punchs->userUniq,
                $punchs->name,
                $punchs->checkInDateTime,
                // Timesheet link added in the vue component
            ];
        }
        
        }
       
        return $rows;
    }
}
