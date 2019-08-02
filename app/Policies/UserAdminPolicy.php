<?php namespace App\Policies;

use Log;
use App\User;
use App\UserAdmin;
use App\UserRole;
use Illuminate\Auth\Access\HandlesAuthorization;

class UserAdminPolicy
{
    use HandlesAuthorization;

    /**
     * Determine if the user is authorized to make this request.
     *
     * // Auth user must be on this project
     * // inverseapplications/punchcard-central/issues/88
     *
     * @return bool
     */
    public function timesheets(User $user, UserAdmin $incomingUser, UserRole $userRole)
    {
        return $this->view($user, $incomingUser, $userRole);
    }
}
