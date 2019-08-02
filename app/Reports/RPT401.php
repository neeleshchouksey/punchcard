<?php namespace App\Reports;

use Auth;
use App\User;
use App\Project;
use App\Check;
use \Carbon\Carbon;
use Illuminate\Http\Request; // faking it
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT401 extends ReportDataAbstract
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
    // Option Data for 401:
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
            'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjects(false),
        ];
    }

    protected function getColumns()
    {
        return ['Date','PUNCH IN', 'PUNCH OUT', 'TOTAL HOURS'];
    }

    protected function getRows()
    {
        //dd($this->inData);
        if (!$this->inData) {
            return null;
        }

        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $user = User::where('uniq_id', $this->inData['user']['value'])->first();

        $checks = Check::with('project', 'user')
                    ->where('project_id', $project->id)
                    ->where('user_id', $user->id)
                    ->whereNotNull('checkOutDateTime')
                    ->orderBy('checkInDateTime', 'DESC');

        $checks = $this->addCheckDatesIfNecessary($checks);
        $checks = $checks->paginate(9999);

        $newChecks = $checks->map(function ($item, $key) {

            $dateIn   = $this->makeDate($item->checkInDateTime);
            $dateOut  = $this->makeDate($item->checkOutDateTime);
            $dateDiff = $this->dateDiffHours($dateIn, $dateOut);

            $this->runningTotal('total', $dateDiff);
            $checkInDateTime = \Carbon\Carbon::parse($item->checkInDateTime);

            // print_r($checkInDateTime->toDateTimeString());die;

            $ret = [
                // $dateIn->format('m/d/Y h:i A'),
                // $dateOut->format('m/d/Y h:i A'),
                $item->checkInDateTime,
                $checkInDateTime->toDateString(),
                $item->checkOutDateTime,
                $dateDiff
            ];

            return $ret;
        });

        $newChecks[] = ['Total', '', $this->runningTotal('total')];
        return $newChecks;
    }
}
