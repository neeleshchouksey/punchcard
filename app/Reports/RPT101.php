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

class RPT101 extends ReportDataAbstract
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
    // Option Data for 101:
    //  - Only date options
    //
    public function gatherOptionData($viewingUser)
    {
        $authUser = (new ClientsAccess($viewingUser))->getAsType();
        $clients  = new ClientsPermittedToAccess(new Request, $authUser);
        return [
         'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])->getManyClients(false)
                               ];
    }


    protected function getColumns()
    {
        return [
            'IHOS Client Summary',
            'Companies',
            'Number of Projects',
            'Number of Employees',
            'Total hours',
            'Detail'
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }
    
        $parents = Client::with('children')
            ->where('child_of_id', 0)
            ->where('id', '<>', 1) // IHOS
            ->where('uniq_id', '=', $this->inData['client']['value']) 
            ->get();

        $rows = [];
        foreach ($parents as $parent) {
            foreach ($parent->children as $child) {

                $numEmployees = User::where('client_id', $child->id)->count();
                $numProjectsStaffedOnAsCompany = DB::table('client_project')->where('client_id', $child->id)->count();
                $checkData    = new CheckStatsData;
                $totalHours   = $checkData->totalHoursByClientId($child->id, $this->inData['startDate'], $this->inData['endDate']);

                $rows[] = [
                    $parent->name,
                    $child->name,
                    $numProjectsStaffedOnAsCompany,
                    $numEmployees,
                    $totalHours,
                    $child->uniq_id
                ];
            }
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
