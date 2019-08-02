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
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT100 extends ReportDataAbstract
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
    // Option Data for 100
    //  - Only date options
    //
    public function gatherOptionData($viewingUser)
    {
        $authUser = (new ClientsAccess($viewingUser))->getAsType();
        $clients  = new ClientsPermittedToAccess(new Request, $authUser);

        return [
            'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
                                   ->getManyClients(false),
        ];
    }


    protected function getColumns()
    {
        return [
            'Parent Company',
            'Projects',
            'Child Companies',
            'Employees',
            'Total hours',
            'Detail'
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $parents = Client::where('child_of_id', 0)
            ->where('id', '<>', 1)
            ->where('uniq_id', $this->inData['client']['value']) // IHOS
            ->get();

        $rows = [];
        foreach ($parents as $parent) {
            $numEmployees = User::where('client_id', $parent->id)->count();
            $numClients   = DB::table('clients')->where('child_of_id', $parent->id)->count();
            $numProjects  = DB::table('projects')->where('client_id', $parent->id)->count();
            $checkData    = new CheckStatsData;
            $totalHours   = $checkData->totalHoursByClientId($parent->id, $this->inData['startDate'], $this->inData['endDate']);

            $rows[] = [
                $parent->name,
                $numProjects,
                $numClients,
                $numEmployees,
                $totalHours,
                $parent->uniq_id
            ];
        }

        return $rows;

        // return [
        //     'IHOS Client Summary',
        //     'Companies',
        //     'Number of Projects',
        //     'Number of Employees',
        //     'Total hours',
        //     'Detail'
        // ];

    }
}
