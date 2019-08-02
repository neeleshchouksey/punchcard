<?php namespace App\System;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\OutsideFenceNoReasonException;
use Carbon\Carbon;
use App\Contracts\UserLogInterface;
use App\ProjectUser;
use App\Check;

class CheckOut extends Check
{
    protected $table = 'checks';

    /**
     * During events like 'project deactivated' or 'user removed'
     * we need to close out anyone who was checked in during that
     * time. This is where we do that. It's typically fired
     * from an event
     */
    public function forceOut($data)
    {
        $me = self::where('project_id', $data['project_id'])
            ->where('user_id', $data['user_id'])
            ->whereNotNull('checkInDateTime')
            ->whereNull('checkOutDateTime')
            ->first();

        if (! $me) {
            return true;
        }

        $me->checkOutDateTime = Carbon::now();
        $me->save();
    }
}
