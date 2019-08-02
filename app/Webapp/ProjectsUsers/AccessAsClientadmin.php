<?php namespace App\Webapp\ProjectsUsers;

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
        return null; // NOT DONE BUT DON'T NEED YET




        $self = $this;
        return UserWebapp::join('clients', 'users.client_id', '=', 'clients.id')
                         ->where('uniq_id', $uniq_id)
                         // these need to be WHERE uniq_id = ? AND (clients.id = ? OR clients.child_of_id = ?)
                         ->orWhere('clients.id', $self->authUser->client_id)
                         ->orWhere('clients.child_of_id', $self->authUser->client_id);
    }

    public function getMany()
    {
        return UserWebapp::join('clients', 'users.client_id', '=', 'clients.id')
                         ->orWhere('clients.id', $this->authUser->client_id)
                         ->orWhere('clients.child_of_id', $this->authUser->client_id);
    }
}
