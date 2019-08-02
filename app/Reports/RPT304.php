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

class RPT304 extends ReportDataAbstract
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
    // Option Data for 304
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
            'Day',
            'Description',
            'High/Low',
            'Wind',
            'Humidity'
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

        $staffed = DB::table('weather_store') 
        ->where('project_id','=',$project_id)
        ->whereBetween('created_at', [$this->inData['startDate'], $this->inData['endDate']])
        ->get();
        
        $rows = [];
        foreach ($staffed as $staffedUser) {
           
            $rows[] = [
                date("l", strtotime($staffedUser->created_at)).' '.$staffedUser->day,
                $staffedUser->description,
                $staffedUser->temp_max.'/'.$staffedUser->temp_min,
                $staffedUser->wind,
                $staffedUser->humidity
            ];
        }

        return $rows;
    }
}
