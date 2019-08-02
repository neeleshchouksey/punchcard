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
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;

class RPT300 extends ReportDataAbstract
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
    // Option Data for 300
    //  - list of clients they have access to
    //  - date options
    //
    public function gatherOptionData($viewingUser)
    {
        $authUser    = (new ClientsAccess($viewingUser))->getAsType();
        $clients     = new ClientsPermittedToAccess(new Request, $authUser);

        return [
            'clients'    => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
                                ->getManyClients(false),
        ];
    }



    protected function getColumns()
    {
        return [
            'ID',
            'Project Name',
            'Number of Companies',
            'Number of Employees',
            'Total hours',
            'List Employees',
            'List Companies'
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $client   =  Client::where('uniq_id', $this->inData['client']['value'])->first();
        $projects = Project::where('client_id', $client->id)->get();

        $rows = [];
        foreach ($projects as $project) {
            $numEmployees = DB::table('project_user')->where('project_id', $project->id)->count();
            $numClients   = DB::table('client_project')->where('project_id', $project->id)->count();
            $checkData    = new CheckStatsData;
            $totalHours   = $checkData->totalHoursByProjectId($project->id, $this->inData['startDate'], $this->inData['endDate']);

            $rows[] = [
                $project->uniq_id,
                $project->name,
                $numClients,
                $numEmployees,
                $totalHours,
            ];
        }

        return $rows;
    }
}
