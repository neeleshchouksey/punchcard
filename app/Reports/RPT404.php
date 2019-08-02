<?php namespace App\Reports;

use Auth;
use App\User;
use App\Project;
use App\Client;
use DB;
use App\SearchProjectsUsers;
use App\Check;
use App\Helpers\ChecksOvertimeCalculator;
use \Carbon\Carbon;
use Illuminate\Http\Request; // faking it
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;

class RPT404 extends ReportDataAbstract
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
    // Option Data for 404:
    //  - list of projects the current user can see
    //  - list of users on each of those projects, filtered when they change projects
    //
    public function gatherOptionData($viewingUser)
    {
        $authProject = (new ProjectsAccess($viewingUser))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);
        
        $authUser = (new ClientsAccess($viewingUser))->getAsType();
        $clients  = new ClientsPermittedToAccess(new Request, $authUser);

        $authUser    = (new UsersAccess($viewingUser))->getAsType();
        $users       = new UsersPermittedToAccess(new Request, $authUser); 

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
        return ['First Name', 'Last Name', 'Week of', 'Day', 'Regular Hours', 'Overtime Hours', 'Total Time'];
        // ['First Name', 'Last Name', 'Week of', 'Day', 'Regular Hours', 'OVERTIME HOURS', 'TOTAL TIME']
    }

    // get all employees on the project
    // loop over them, get their hours, add them up PER DAY
    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $client  = Client::where('uniq_id', $this->inData['client']['value'])->first();
        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $user = User::where('uniq_id', $this->inData['user']['value'])->first();
        $users   = DB::table('project_user')->join('users', 'project_user.user_id', '=', 'users.id')
                                                 ->where('project_id', $project->id)
                                                 ->where('users.client_id', $client->id)
                                                 ->where('users.id', $user->id)
                                                 ->first();

        $rows = [];
        if(!empty($users)){

        $jdocDecode = json_decode($users->jdoc);
        

        if(! empty($jdocDecode->scheduling->dailyEndTime)){
            
            $dailyEndTime = $jdocDecode->scheduling->dailyEndTime.':00';
            $punchs = DB::table('checks') 
            ->join('users', 'users.id', '=', 'checks.user_id')
            ->select('checks.*','users.first_name','users.last_name', 'users.uniq_id as userUniq')
            ->whereNotNull('checkOutDateTime')
            ->where('users.deleted_at','=',NULL)
            ->where('checks.project_id','=',$project->id)
            ->where('checks.user_id','=',$user->id)
            ->where(DB::raw('CAST("checks"."checkOutDateTime" AS time)'),'>=',$dailyEndTime)
            // ->where(DB::raw('CAST("checks"."checkInDateTime" AS DATE)'),'>',$this->inData['startDate'])
            // ->where(DB::raw('CAST("checks"."checkInDateTime" AS DATE)'),'<',$this->inData['endDate'])
            ->whereBetween('checks.checkInDateTime', [$this->inData['startDate'], $this->inData['endDate']])
            ->get();

            $new_posts = array();
 
            foreach( $punchs as $post ) {
              
              $week = date('W', strtotime($post->created_at));
             
              if( !isset($new_posts[$week]) ) {
                $new_posts[$week] = array();
              }
             
              $new_posts[$week][] = $post;

            }

            foreach ($new_posts as $week => $datas) {

                $i = 1;
                
                foreach ($datas as $data) {
                    
                 $datetime1 = date("H:i:s",strtotime($data->checkOutDateTime));
                 $checkoutDateYear = date("Y",strtotime($data->checkOutDateTime));

                 $weekStartDate = $this->getStartAndEndDate($week, $checkoutDateYear);


                 $datetime2 = date("H:i:s",strtotime($dailyEndTime));


                 $time =  (new Carbon($datetime1))->diff(new Carbon($datetime2))->format('%h:%I') ;
                 
                 if($i == 1){
                    $time2 = "00:00:00";
                    $secs = strtotime($time2)-strtotime("00:00:00");
                    $time2 = date("H:i:s",strtotime($time)+$secs);
                 }else{
                    $secs = strtotime($time2)-strtotime("00:00:00");
                    $time2 = date("H:i:s",strtotime($time)+$secs);
                 }
                 
                 $first_name = $data->first_name;
                 $last_name = $data->last_name;

                 $i++;
                }    

                $overtimeHours = $time2;
                $weekOf        = $weekStartDate;
                $day = date("l", strtotime($weekOf));

                $regularHours = 40;

                $addTime = explode(':', $overtimeHours);
                $total_time = $regularHours + $addTime[0];
                $total_time = $total_time.':'.$addTime[1].':'.$addTime[2];              
                

                $rows[] = [
                    $first_name,
                    $last_name,
                    $weekOf,
                    $day,
                    $regularHours,
                    $overtimeHours,
                    $total_time,
                ];
            }
                return $rows;
        }
    }

}

    protected function getStartAndEndDate($week, $year)
    {

        $time = strtotime("1 January $year", time());
        $day = date('w', $time);
        $time += ((7*$week)+1-$day)*24*3600;
        // $return[0] = date('Y-n-j', $time);
        // $time += 6*24*3600;
        // $return[1] = date('Y-n-j', $time);
        return date('Y-n-j', $time);
    }

    
}
