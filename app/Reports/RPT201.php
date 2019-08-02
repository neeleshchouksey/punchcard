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

class RPT201 extends ReportDataAbstract
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
    // Option Data for 201:
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
            'First Name',
            'Last Name',
            'ID',
            'Status',
            'Total Days Worked',
            'Total Hours Worked',
            'Timesheet',
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $client  = Client::where('uniq_id', $this->inData['client']['value'])->first();
        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $users   = DB::table('project_user')->join('users', 'project_user.user_id', '=', 'users.id')
                                                 ->where('project_id', $project->id)
                                                 ->where('users.client_id', $client->id)
                                                 ->get();
        $rows = [];
        foreach ($users as $user) {
            $checkData    = new CheckStatsData;
            $totalHours   = $checkData->totalHoursByProjectAndUserId($user->project_id, $user->user_id, $this->inData['startDate'], $this->inData['endDate']);
            $totalDays    = ($totalHours > 0) ? round($totalHours / config('ihos.workDayHours')) : 0;
            $rows[] = [
                $user->first_name,
                $user->last_name,
                $user->uniq_id,
                ucfirst($user->status),
                $totalDays,
                $totalHours,

                 // 'TimeSheet' added in vue

            ];
        }

        return $rows;
    }
}
