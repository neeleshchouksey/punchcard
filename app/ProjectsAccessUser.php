<?php namespace App;

use App\Contracts\ProjectsAccessUserInterface;

class ProjectsAccessUser
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getAsType()
    {
        $userType = 'App\ProjectsAccessAs' . ucfirst($this->authUser->role);
        return new $userType($this->authUser);
    }
}
