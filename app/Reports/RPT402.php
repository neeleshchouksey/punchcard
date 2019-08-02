<?php namespace App\Reports;

use Auth;
use App\User;
use App\Project;
use App\Check;
use App\Client;
use \Carbon\Carbon;
use Illuminate\Http\Request; // faking it
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT402 extends ReportDataAbstract
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
    // Option Data for 400:
    //  - list of projects the current user can see
    //  - list of users on each of those projects, filtered when they change projects
    //
    public function gatherOptionData($viewingUser)
    {
        $authUser = (new ClientsAccess($viewingUser))->getAsType();
        $clients  = new ClientsPermittedToAccess(new Request, $authUser);

        $authUser    = (new UsersAccess($viewingUser))->getAsType();
        $users       = new UsersPermittedToAccess(new Request, $authUser);

        return [
            'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
                                   ->getManyClients(false),

            'users'    => $users->setColumns(['users.id', 'users.uniq_id', 'users.first_name', 'users.last_name'])
                                ->getManyUsers(false),
        ];
    }

    protected function getColumns()
    {
        return ['ID'];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $client  = Client::where('uniq_id', $this->inData['client']['value'])->first();

        $user = User::where('uniq_id', $this->inData['user']['value'])->where('client_id', $client->id)->first();
        if(!empty($user)){
            $user->client;
        $user->append('avatar');

        return [$user];
    }else{
        return [];
        
    }
    }
}
