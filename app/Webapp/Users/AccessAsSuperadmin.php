<?php namespace App\Webapp\Users;

use App\User;
use DB;

class AccessAsSuperadmin implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getOne($uniq_id)
    {
        $self = $this;
        return UserWebapp::join('clients', 'users.client_id', '=', 'clients.id')->where('users.uniq_id', $uniq_id);
    }

    public function getManyForExport()
    {
        return UserWebapp::where('id', '<>', '0'); // all but with query builder
    }

    public function getMany()
    {
        return UserWebapp::join('clients', 'users.client_id', '=', 'clients.id')
                         ->orWhere('clients.id', $this->authUser->client_id)
                         ->orWhere('clients.child_of_id', $this->authUser->client_id);
    }
}
