<?php namespace App;

use App\Exceptions;
use App\UserBadgeData;

class CheckBadge
{
    protected $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function punchIn()
    {
        $project = $this->data['project'];
        $user    = $this->data['user'];

        //
        // PUNCH IN
        //
        $check   = new CheckIn;
        $check_uniq_id = $check->in($this->data, $project, new UserLog(), new ProjectUser());

        //
        // on success, we return the badge URL, for visual confirmation by
        // the person checking people in. The idea is a last-ditch catch
        // by this person to visually confirm the person checked in matches
        // the person standing in front of them.
        //

        $badgeData = new UserBadgeData($user, $project);

        return [
            'check_uniq_id' => $check_uniq_id,
            'badge'         => $badgeData->get()
        ];
    }

    public function punchOut()
    {
        $project = $this->data['project'];
        $user    = $this->data['user'];

        //
        // PUNCH OUT
        //
        $check   = new CheckOut;
        $check_uniq_id = $check->out($this->data, $project, new UserLog(), new ProjectUser());

        //
        // on success, we return the badge URL, for visual confirmation by
        // the person checking people in. The idea is a last-ditch catch
        // by this person to visually confirm the person checked in matches
        // the person standing in front of them.
        //

        $badgeData = new UserBadgeData($user, $project);

        return [
            'badge' => $badgeData->get()
        ];
    }
}
