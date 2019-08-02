<?php namespace App\Webapp\ProjectsUsers;

use App\User;

class Access
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getAsType()
    {
        $userType = 'App\Webapp\Users\AccessAs' . ucfirst($this->authUser->role);
        return new $userType($this->authUser);
    }
}
