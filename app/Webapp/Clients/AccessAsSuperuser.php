<?php namespace App\Webapp\Clients;

use App\User;

class AccessAsSuperuser implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function remove($uniq_id)
    {
        return null;
    }

    public function getOne($uniq_id)
    {
        return ClientWebapp::where('id', $this->authUser->client_id)->where('uniq_id', $uniq_id);
    }

    public function getManyForExport()
    {
        return $this->getMany();
    }

    //
    // Per requirements, no access
    //
    public function getMany()
    {
        return null;
    }
}
