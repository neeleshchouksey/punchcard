<?php namespace App;

use App\Exceptions\OutsideFenceNoReasonException;
use Illuminate\Database\Eloquent\Model;
use App\Contracts\UserLogInterface;
use App\User;
use App\UserLog;
use App\Project;
use DB;

class Check extends Model
{
    public function user()
    {
        return $this->belongsTo('App\User')->select(['id', 'uniq_id', 'first_name', 'last_name']);
    } 

    public function project()
    {
        return $this->belongsTo('App\Project')->select(['id', 'uniq_id', 'name']);
    }

    public function getOnsiteAttribute()
    {
        return ($this->checkInDateTime <> null && $this->checkOutDateTime == null);
    }

    // public function getLastPunch($project_id)
    // {
    //     $this->user->getLastPunch($project_id);
    // }

    public function getLastChecks($project_id)
    {
        $this->user->getLastChecks($project_id);
    }

    public function isCheckedIn($user_id)
    {
        $datacheckIn = $this->with('project')
            ->where('user_id', '=', $user_id)
            ->whereNotNull('checkInDateTime')
            ->whereNull('checkOutDateTime')
            ->select(['checks.id', 'checks.uniq_id', 'checkInDateTime', 'project_id','checkMethod'])
            ->first();
    
        
        return $datacheckIn;
    }

    public static function isCheckedInTo(User $user, Project $project)
    {
        $test = self::where('user_id', '=', $user->id)
            ->where('project_id', '=', $project->id)
            ->whereNotNull('checkInDateTime')
            ->whereNull('checkOutDateTime')
            ->select(['checks.id'])
            ->first();

        return $test;
    }

    protected function existsExceptionReason($data)
    {
        return (isset($data['exceptionReason']) && $data['exceptionReason'] <> null);
    }

    protected function logExceptionReasonIfExists($data, Project $project, UserLogInterface $userLog, $type = 'punch-in exception', $check_id = null)
    {
        if (! $this->existsExceptionReason($data)) {
            return ;
        }

        $userLog->note = $data['exceptionReason'];
        $userLog->type = $type;
        $userLog->user_id = $data['user_id'];
        $userLog->project_id = $project->id;
        // $userLog->check_id = $this->id;
        #edited_by_palash
        if($type == "punch-in exception"){
            $userLog->check_id = $this->id;
        }else{
            $userLog->check_id = $check_id;
        }
        #edited_by_palash

        return $userLog->save();
    }

    protected function abortIfNotInsideFenceAndHasNoException($data, Project $project)
    {
         if (! $project->isWithinCheckinDistance($data['latitude'], $data['longitude']) &&
            ! $this->existsExceptionReason($data)) {
            throw new OutsideFenceNoReasonException('Outside the punch-in region without an Exception Reason');
        }
    }

    protected function abortIfNotOnProject($data, $project, ProjectUser $projectUser)
    {
        $user_id = isset($data['user_id']) ? $data['user_id'] : null;

        if (!$projectUser->isOnProject($project->id, $user_id)) {
            throw new Exceptions\BadInputException("User not on project {$project->uniq_id} ");
        }
    }

    public function isCheckException()
    {

        $userLog = $this->getAssociatedUserLog();

        return ($userLog != null);
    }

    public function checkExceptionNote()
    {
        $userLog = $this->getAssociatedUserLog();

        if ($userLog == null) {
            return null;
        }

        return $this->completeLogNote($userLog);
    }

    protected function completeLogNote($userLog)
    {
        $type = ($userLog->type) ? $userLog->type . ': ' : '';

        return $type . $userLog->note;
    }

    protected function getAssociatedUserLog()
    {
        if (!isset($this->associatedUserLog)) {
            $this->associatedUserLog = UserLog::where('check_id', $this->id)->first();
        }

        return $this->associatedUserLog;
    }
}
