<?php namespace App\Webapp\Clients;

use App\User;

class AccessAsClientadmin implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function remove($uniq_id)
    {
        $client = ClientWebapp::where('uniq_id', $uniq_id)
            ->where('child_of_id', $this->authUser->client_id)
            ->first();

        $client->status = 'inactive';
        $client->save();
        return $client->delete();
    }

    public function getOne($uniq_id)
    {
        $self = $this;
        return ClientWebapp::orWhere(function ($query) use ($self, $uniq_id) {
                            $query->where('id', $self->authUser->client_id)
                                ->where('uniq_id', $uniq_id);
        })
                         ->orWhere(function ($query) use ($self, $uniq_id) {
                             $query->where('child_of_id', $self->authUser->client_id)
                                   ->where('uniq_id', $uniq_id);
                         });
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
