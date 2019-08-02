<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\OutsideFenceNoReasonException;
use App\Traits\UniqIdTrait;
use App\Contracts\UserLogInterface;
use App\ProjectUser;
use DB;
use Carbon\Carbon;

class CheckIn extends Check
{
    use UniqIdTrait;

    protected $table = 'checks';

    public function in($data, Project $project, UserLogInterface $userLog, ProjectUser $projectUser)
    {
      $this->abortIfNotOnProject($data, $project, $projectUser);
       // echo '<pre>';print_r($first );die;
        $this->abortIfAlreadyCheckedIn($data);

         $this->abortIfNotInsideFenceAndHasNoException($data, $project);
//echo '<pre>';print_r($third );die;

        $this->project_id  = $project->id;
        $this->user_id     = $data['user_id'];
        $this->latitudeIn  = $data['latitude'];
        $this->longitudeIn = $data['longitude'];
        $this->checkMethod = $data['checkMethod'];
        $this->checkInDateTime = Carbon::now(); //server_time(add_by_palash)
        // if(isset($data['exceptionReason'])){
        //     if($data['exceptionReason'] == 'Face Input'){
        //     $this->checkMethod = 'face';
        // }
        // }

        $reason=$this->isExceptionIn = !$project->isWithinCheckinDistance($data['latitude'], $data['longitude']);
        // echo '<pre>';print_r($reason );die;
        $this->save();
        $this->logExceptionReasonIfExists($data, $project, $userLog, 'punch-in exception');

        return $this->uniq_id;
    }

    protected function abortIfAlreadyCheckedIn($data)
    {
        if (! isset($data['user_id'])) {
            throw new Exceptions\BadInputException('No user_id');
        }

        if ($this->isCheckedIn($data['user_id'])) {

            if (array_key_exists("project_id",$data)){

                $userCheckedIn = DB::table('checks')->where('user_id', $data['user_id'])->where('project_id', $data['project_id'])->where('checkOutDateTime',NULL)->first();
                if(!empty($userCheckedIn)){
                    throw new \Exception('Already checked-in');
                    die;
                }else{
                    throw new \Exception('Already checked-in into another project');
                    die;
                }
            }
                       
            throw new \Exception('Already checked-in');
            
        }
    }
}
