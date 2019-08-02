<?php namespace App\Webapp\Clients;

use App\User;

class AccessAsAdmin implements AccessInterface
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

    public function getMany()
    {
        return ClientWebapp::where('clients.id', $this->authUser->client_id)
                          ->orWhere('clients.child_of_id', $this->authUser->client_id);
    }
}
