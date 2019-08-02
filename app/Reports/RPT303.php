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

class RPT303 extends ReportDataAbstract
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
    // Option Data for 303
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
            'ID',
            'Company Name',
            'Number Of Employees',
            'Employess'
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

        $staffed = DB::table('clients') 
        ->join('users', 'clients.id', '=', 'users.client_id')
        ->join('checks', 'users.id', '=', 'checks.user_id')
        ->select(DB::raw('count(*) as user_count, clients.name'),'clients.uniq_id')
        ->where('checks.checkOutDateTime','=',NULL)
        ->where('checks.project_id','=',$project_id)
        ->where('users.deleted_at','=',NULL)
        // ->whereBetween('checks.checkInDateTime', [$this->inData['startDate'], $this->inData['endDate']])
        ->groupBy('clients.name','clients.uniq_id')
        ->get();
        
        $rows = [];
        foreach ($staffed as $staffedUser) {
           
            $rows[] = [
                $this->inData['project']['value'].'/'.$staffedUser->uniq_id,
                $staffedUser->name,
                $staffedUser->user_count,
                // View Employess link added in the vue component
            ];
        }

        return $rows;
    }
}
