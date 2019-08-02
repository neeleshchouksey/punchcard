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

class RPT301 extends ReportDataAbstract
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
    // Option Data for 301
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
            'Parent Company',
            'Total Days',
            'Total hours',
            'Last Punch',
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

        $rows = [];
        foreach ($staffed as $staffedUser) {
            $user = User::where('uniq_id', $staffedUser->uniq_id)->first();

            if (!$user) {
                continue;
            }

            $user->addLastChecks($project->id);

            $numEmployees = DB::table('project_user')->where('project_id', $project->id)->count();
            $numClients   = DB::table('client_project')->where('project_id', $project->id)->count();
            $checkData    = new CheckStatsData;
            $totalHours   = $checkData->totalHoursByProjectAndUserId($project->id, $user->id, $this->inData['startDate'], $this->inData['endDate']);
            $totalDays    = ($totalHours > 0) ? round($totalHours / config('ihos.workDayHours')) : 0;

            $rows[] = [
                $user->name,
                $user->uniq_id,
                $user->client->name,
                $totalDays,
                $totalHours,
                $user->lastCheckIn,
                // Timesheet link added in the vue component
            ];
        }

        return $rows;
    }
}
