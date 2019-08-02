<?php namespace App\Reports;

use Auth;
use App\User;
use App\Project;
use App\Check;
use DB;
use App\CheckStatsData;
use Illuminate\Http\Request; // faking it
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT500 extends ReportDataAbstract
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
            // 'clients' => $clients->setColumns(['clients.id', 'clients.uniq_id', 'clients.name'])
            //                        ->getManyClients(false),
            'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjects(false),
        ];
    }

    protected function getColumns()
    {
        return ['First Name', 'Last Name', 'Pay Rate', 'Total Hours', 'Total'];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $user    = User::where('uniq_id', $this->inData['user']['value'])->first();

        // print_r($user);die;

        $jdoc = json_decode(json_encode($user->jdoc, true));

        $payRate = $jdoc->payroll_data->pay_rate;

        if(empty($payRate)){
            $payRate = 0;
        }

        $checkData    = new CheckStatsData;
        $totalHours   = $checkData->totalHoursByProjectAndUserId($project->id, $user->id, $this->inData['startDate'], $this->inData['endDate']);

        $total = $totalHours*$payRate;

        

            $ret[] = [
                $user->first_name,
                $user->last_name,
                $payRate,
                $totalHours,
                $total,
                
            ];

            return $ret;


        
    }

    // #119; hard code 7:30
    protected function arrivedLate($dateTime, $user_id)
    {
         $jdocDailyStartTime = DB::table('users')->select('jdoc')->where('id','<=', $user_id)->first();
         // return $jdocDailyStartTime->jdoc;
        $json_decode = json_decode($jdocDailyStartTime->jdoc, true);
        $json_decode['scheduling']['dailyStartTime'];
        $dateArrived = $this->makeDate($dateTime);

        $date730 = $this->makeDate($dateArrived->format('Y-m-d 12:30:00')); // per Matt: 7:30 but we have UTC too

        $dateDiff = $date730->diffInMinutes($dateArrived, false);

        return $dateDiff > 0;
    }

    // #119; hard code 17:00
    protected function leftEarly($dateTime)
    {
        $dateLeft = $this->makeDate($dateTime);

        $date1700 = $this->makeDate($dateLeft->format('Y-m-d 22:00:00')); // per Matt: 17:00 but we have UTC too

        $dateDiff = $date1700->diffInMinutes($dateLeft, false);

        return $dateDiff < 0;
    }
}
