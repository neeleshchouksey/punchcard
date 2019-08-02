<?php namespace App\Webapp\Users;

use App\User;

class AccessAsClientadmin implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getOne($uniq_id)
    {
        $self = $this;
        return UserWebapp::join('clients', 'users.client_id', '=', 'clients.id')
                ->where('users.uniq_id', $uniq_id)
                ->where(function ($query) use ($self) {
                     // these need to be WHERE uniq_id = ? AND (clients.id = ? OR clients.child_of_id = ?)
                     $query->orWhere('clients.id', $self->authUser->client_id)
                           ->orWhere('clients.child_of_id', $self->authUser->client_id);
                });
    }

    public function getManyForExport()
    {
        return $this->getMany();
    }

    public function getMany()
    {
        return UserWebapp::join('clients', 'users.client_id', '=', 'clients.id')
                         ->orWhere('clients.id', $this->authUser->client_id)
                         ->orWhere('clients.child_of_id', $this->authUser->client_id);
    }
}
