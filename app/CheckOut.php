<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\OutsideFenceNoReasonException;
use Carbon\Carbon;
use App\Contracts\UserLogInterface;
use App\ProjectUser;

class CheckOut extends Check
{
    protected $table = 'checks';

    public function out($data, Project $project, UserLogInterface $userLog, ProjectUser $projectUser)
    {
        $this->abortIfNotOnProject($data, $project, $projectUser);
        $this->abortIfNotAlreadyCheckedIn($data);

/* below line me error he */     
$this->abortIfNotInsideFenceAndHasNoException($data, $project);

//echo '<pre>';print_r($a);die;

        $me = self::where('project_id', $data['project_id'])
            ->where('user_id', $data['user_id'])
            ->whereNotNull('checkInDateTime')
            ->whereNull('checkOutDateTime')
            ->first();


        $me->latitudeOut  = $data['latitude'];
        $me->longitudeOut = $data['longitude'];
        $me->checkOutDateTime = Carbon::now();

        $me->isExceptionOut = !$project->isWithinCheckinDistance($data['latitude'], $data['longitude']);
        $me->save();

        $this->logExceptionReasonIfExists($data, $project, $userLog, 'punch out exception', $me['id']); //edited_by_palash
    }

    protected function abortIfNotAlreadyCheckedIn($data)
    {
        if (! isset($data['user_id'])) {
            throw new Exceptions\BadInputException('No user_id');
        }

        if (! $this->isCheckedIn($data['user_id'])) {
            throw new Exceptions\BadInputException('Not checked-in');
        }
    }
}
