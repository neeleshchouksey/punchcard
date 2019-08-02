<?php namespace App\Webapp\Clients;

use App\User;

class AccessAsUser implements AccessInterface
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


    //
    // Per requirements, no access
    //
    public function getOne($uniq_id)
    {
        return null;
    }

    public function getManyForExport()
    {
        return $this->getMany();
    }

    public function getMany()
    {
        return null;
    }
}
