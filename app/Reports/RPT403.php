<?php namespace App\Reports;

use Auth;
use App\User;
use App\Project;
use App\Check;
use App\Client;
use DB;
use App\UserLog;
use Illuminate\Http\Request; // faking it
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT403 extends ReportDataAbstract
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
            'projects' => $projects->setColumns(['projects.id', 'projects.uniq_id', 'projects.name'])
                                   ->getManyProjects(false),
        ];
    }

    protected function getColumns()
    {
        return ['ID','First Name', 'Last Name', 'Date', 'Day', 'In', 'Log/Comments', 'Timesheet'];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }
        
        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $user = User::where('uniq_id', $this->inData['user']['value'])->first();
        $client  = Client::where('uniq_id', $this->inData['client']['value'])->first();
       
        $uniqID = $this->inData['user']['value'];
        $name   =  $this->inData['user']['text'];
        $nameArr = explode(' ', $name);
       
        $rows = [];

        if(! empty($user->jdoc['scheduling']['dailyStartTime'])){

            $dailyStartTime = $user->jdoc['scheduling']['dailyStartTime'].':00';
            $punchs = DB::table('checks') 
            ->join('users', 'users.id', '=', 'checks.user_id')
            ->select('checks.*','users.first_name','users.last_name', 'users.uniq_id as userUniq')
            ->whereNotNull('checkOutDateTime')
            ->where('users.deleted_at','=',NULL)
            ->where('users.client_id', $client->id)
            ->where('checks.project_id','=',$project->id)
            ->where('checks.user_id','=',$user->id)
            ->where(DB::raw('CAST("checks"."checkInDateTime" AS time)'),'>=',$dailyStartTime)
            // ->where(DB::raw('CAST("checks"."checkInDateTime" AS DATE)'),'>',$this->inData['startDate'])
            // ->where(DB::raw('CAST("checks"."checkInDateTime" AS DATE)'),'<',$this->inData['endDate'])
            ->whereBetween('checks.checkInDateTime', [$this->inData['startDate'], $this->inData['endDate']])
            ->get();

            // print_r($punchs);die;

             // $punchs  = DB::select("SELECT "checks".*, "users"."first_name", "users"."last_name", "users"."uniq_id" AS "userUniq" FROM "checks" INNER JOIN "users" on "users"."id" = "checks"."user_id" where "checkOutDateTime" is not null AND "users"."deleted_at" is null AND "project_id" = 16 AND "user_id" = 135 AND CAST("checks"."checkInDateTime" AS time) > '01:15:00' AND "checks"."created_at" between '2017-02-02' and '2018-02-02';");

            $newData = array();

            foreach ($punchs as $punch) {
                
               $punch = json_decode(json_encode($punch),true);
                
               $userLogs = DB::table('user_logs')->where('check_id',$punch['id'])->where('type','punch-in exception')->first();
               $userLogs = json_decode(json_encode($userLogs),true);
            
               $note = $userLogs['note'];
               $punch['note'] = $note;
              
               $newData[] = $punch;
    
            }
        foreach ($newData as $data) {

            if(empty($data['note'])){
                $data['note']='NA';
            }
           
            $rows[] = [
                $uniqID,
                $nameArr[0],
                $nameArr[1],
                date('Y-m-d',strtotime($data['checkInDateTime'])),
                date("l", strtotime($data['checkInDateTime'])),
                date('H:i:s',strtotime($data['checkInDateTime'])),
                $data['note']
            ];
        }
    }

        return $rows;
    }
    
}
