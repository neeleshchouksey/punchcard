<?php namespace App\Webapp\ProjectsUsers;

use App\User;

class AccessAsSuperuser implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getOne($uniq_id)
    {
        return UserWebapp::where("client_id", $this->authUser->client_id)->where('uniq_id', $uniq_id);
    }

    public function getMany()
    {
        return UserWebapp::where("client_id", $this->authUser->client_id);
    }
}
