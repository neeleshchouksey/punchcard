<?php namespace App\Observers;

use App\Webapp\Users\Add as UserAdd;

class UserObserver
{
    public function created(UserAdd $user)
    {
        $user->sendRegistrationConfirmation();
    }

    // public function deleting(UserAdd $user)
    // {
    //     // can move the 'remove from projects' here
    // }
}
