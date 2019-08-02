<?php namespace App\Webapp\Reports;

use App\User;
use Illuminate\Http\Request; // faking it

// use App\Webapp\Users\Access as UsersAccess;
// use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
//
// use App\Webapp\Clients\Access as ClientsAccess;
// use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;
//
// use App\Webapp\Reports\Access as ReportsAccess;
// use App\Webapp\Reports\PermittedToAccess as ReportsPermittedToAccess;
//
// use App\ProjectsAccessUser as ProjectsAccess;
// use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;

class ReportOptionData
{
    protected $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }


        /*
    public function gather()
    {
        $authUser    = (new UsersAccess($this->user))->getAsType();
        $users       = new UsersPermittedToAccess(new Request, $authUser);

        $authClient  = (new ClientsAccess($this->user))->getAsType();
        $clients     = new ClientsPermittedToAccess(new Request, $authClient);

        $authProject = (new ProjectsAccess($this->user))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);

        $authReport  = (new ReportssAccess($this->user))->getAsType();
        $reports     = new ReportsPermittedToAccess(new Request, $authReport);

        return [
            'users' => $users->setColumns(['users.id', 'users.uniq_id', 'users.first_name', 'users.last_name'])
                             ->getManyUsers(false),
            'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
                                 ->getManyClients(false),
            'clients_projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjects(false),
            'users_projects' => $reports->getManyUsersProjects(false),
        ];

        //dd($this->user);
    }
         */

    public function gather(ReportWebapp $report)
    {
        $filteredNumber = $this->getFilteredNumber($report);
        $class  = "App\Reports\\$filteredNumber";
        $reportForOptionData = new $class();

        if (!$reportForOptionData) {
            throw new \LogicException ("Report {$filteredNumber} data file not found");
        }

        $data = $report;
        $data->reportOptionData = $reportForOptionData->gatherOptionData($this->user);

        return $data;
    }

    protected function getFilteredNumber($report)
    {
        return str_replace('-', '', $report->report_number);
    }
}
