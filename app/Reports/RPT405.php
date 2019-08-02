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

class RPT405 extends ReportDataAbstract
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
    // Option Data for 405
    //  - list of projects they have access to
    //  - list of users on those projects
    //  - date options
    //
    public function gatherOptionData($viewingUser)
    {
        $authUser    = (new UsersAccess($viewingUser))->getAsType();
        $users       = new UsersPermittedToAccess(new Request, $authUser);

        $authUser = (new ClientsAccess($viewingUser))->getAsType();
        $clients  = new ClientsPermittedToAccess(new Request, $authUser);

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
        return [
            'Date',
            'In',
            'Onsite',
            'Log/Comment',
            'Date',
            'Out',
            'Onsite',
            'Log/Comment'
        ];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }
        
        $project = Project::where('uniq_id', $this->inData['project']['value'])->first();
        $user = User::where('uniq_id', $this->inData['user']['value'])->first();
       
        
        $rows = [];

            $punchs = DB::table('checks') 
            ->join('users', 'users.id', '=', 'checks.user_id')
            ->select('checks.*','users.first_name','users.last_name', 'users.uniq_id as userUniq')
            ->whereNotNull('checkOutDateTime')
            ->where('users.deleted_at','=',NULL)
            ->where('project_id','=',$project->id)
            ->where('user_id','=',$user->id)
            ->whereBetween('checks.created_at', [$this->inData['startDate'], $this->inData['endDate']])
            ->get(); 

            $newData = array();

            foreach ($punchs as $punch) {
                
               $punch = json_decode(json_encode($punch),true);
                
               $userLogs = DB::table('user_logs')->where('check_id',$punch['id'])->where('type','punch-in exception')->first();
               $userLogs = json_decode(json_encode($userLogs),true);

               $userLogs_out = DB::table('user_logs')->where('check_id',$punch['id'])->where('type','punch out exception')->first();
               $userLogs_out = json_decode(json_encode($userLogs_out),true);
            
               $note = $userLogs['note'];
               $punch['note_in'] = $note;

               $note_out = $userLogs_out['note'];
               
               $punch['note_out'] = $note_out;
              
               $newData[] = $punch;
    
            }
        foreach ($newData as $data) {

            if(empty($data['note_in'])){
                $data['note_in']='NA';
            }
            if(empty($data['note_out'])){
                $data['note_out']='NA';
            }

            if($data['isExceptionIn'] == true){

                $data['isExceptionIn'] = 'yes';
            }else{
                $data['isExceptionIn'] = 'no';

            }
            if($data['isExceptionOut'] == true){
                $data['isExceptionOut'] = 'yes';
            }else{
                $data['isExceptionOut'] = 'no';

            }


           
            $rows[] = [
                date('Y-m-d',strtotime($data['checkInDateTime'])),
                date('H:i:s',strtotime($data['checkInDateTime'])),
                $data['isExceptionIn'],
                $data['note_in'],
                date('Y-m-d',strtotime($data['checkOutDateTime'])),
                date('H:i:s',strtotime($data['checkOutDateTime'])),
                $data['isExceptionOut'],
                $data['note_out']
            ];
        }
    

        return $rows;
    }
}
