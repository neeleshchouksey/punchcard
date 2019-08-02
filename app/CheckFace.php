<?php namespace App;

use App\Exceptions;

class CheckFace
{
    public function punchIn($data)
    {
        $project = $data['project'];
        $user    = $data['user'];

        //
        // PUNCH IN
        //
        $check   = new CheckIn;
        $check_uniq_id = $check->in($data, $project, new UserLog(), new ProjectUser());

        //
        // on success, we return the badge URL, for visual confirmation by
        // the person checking people in. The idea is a last-ditch catch
        // by this person to visually confirm the person checked in matches
        // the person standing in front of them.
        //

        $data = [
            'check_uniq_id' => $check_uniq_id
        ];

        return $data;
    }

    public function punchOut($data)
    {
        $project = $data['project'];
        $user    = $data['user'];

        //
        // PUNCH OUT
        //
        $check   = new CheckOut;
        $check_uniq_id = $check->out($data, $project, new UserLog(), new ProjectUser());

        //
        // on success, we return the badge URL, for visual confirmation by
        // the person checking people in. The idea is a last-ditch catch
        // by this person to visually confirm the person checked in matches
        // the person standing in front of them.
        //

        return [];
    }

}
