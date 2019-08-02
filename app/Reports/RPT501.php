<?php namespace App\Reports;

use Auth;
use App\User;
use App\Client;
use App\Check;
use DB;
use Illuminate\Http\Request; // faking it
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT501 extends ReportDataAbstract
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
    // Option Data for 403:
    //  - list of projects the current user can see
    //  - list of users on each of those projects, filtered when they change projects
    //
    public function gatherOptionData($viewingUser)
    {
        $authUser = (new ClientsAccess($viewingUser))->getAsType();
        $clients  = new ClientsPermittedToAccess(new Request, $authUser);

        $authUser    = (new UsersAccess($viewingUser))->getAsType();
        $users       = new UsersPermittedToAccess(new Request, $authUser);

        $authProject = (new ProjectsAccess($viewingUser))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);

        return [
            'users'    => $users->setColumns(['users.id', 'users.uniq_id', 'users.first_name', 'users.last_name'])
                                ->getManyUsers(false),
            'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
                                   ->getManyClients(false),
            // 'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
            //                        ->getManyProjects(false),
        ];
    }

    protected function getColumns()
    {
        return ['Class Code', 'Name', 'Estimated Hours', 'Pay Rate', 'Total Estimated WC Premium
'];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $client = Client::where('uniq_id', $this->inData['client']['value'])->first();
        $user    = User::where('uniq_id', $this->inData['user']['value'])->where('client_id',$client->id)->first();

        // print_r($user->jdoc['payroll_data']['wcGocClassCode']);die;

        if(!isset($user->jdoc['payroll_data']['wcGocClassCode']) && !isset($user->jdoc['payroll_data']['estimatedHoursMonth']) && !isset($user->jdoc['payroll_data']['pay_rate']) && !isset($user->jdoc['payroll_data']['estimatedPremium'])){
            die;
        }
       

        
        
        $ret[] = [
            $user->jdoc['payroll_data']['wcGocClassCode'],
            $user->first_name.' '.$user->last_name,
            $user->jdoc['payroll_data']['estimatedHoursMonth'],
            $user->jdoc['payroll_data']['pay_rate'],
            $user->jdoc['payroll_data']['estimatedPremium']
        ];

            return $ret;
       

        
    }

    
}
