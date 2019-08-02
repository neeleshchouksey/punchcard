<?php namespace App\Webapp\Users;

use App\User;

class AccessAsUser implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
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
