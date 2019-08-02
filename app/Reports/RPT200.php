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
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT200 extends ReportDataAbstract
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
    // Option Data for 200:
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
            'ID',
            'Company Name',
            'Number of Employees',
            'Total hours',
            'List Employees'
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

    
        $client_id = DB::table('clients')->where('uniq_id', $this->inData['client']['value'])->first();
        
        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $clientProjects = ClientProject::with('client')->where('project_id', $project->id)->where('client_id', $client_id->id)->get();

        $rows = [];
        foreach ($clientProjects as $cp) {
            $numEmployees = DB::table('project_user')->join('users', 'project_user.user_id', '=', 'users.id')
                                                     ->where('project_id', $cp->project_id)
                                                     ->where('users.client_id', $cp->client_id)
                                                     ->count();
            $checkData    = new CheckStatsData;
            $totalHours   = $checkData->totalHoursByProjectAndClientId($cp->project_id, $cp->client_id, $this->inData['startDate'], $this->inData['endDate']);

            $rows[] = [
                $cp->client->uniq_id,
                $cp->client->name,
                $numEmployees,
                $totalHours,
                // 'Employees Detail' added in vue
            ];
        }

        return $rows;
    }
}
