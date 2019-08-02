<?php namespace App\Webapp\Clients;

use App\User;

class AccessAsSuperadmin implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function remove($uniq_id)
    {
        $client = ClientWebapp::where('uniq_id', $uniq_id)->first();
        $client->status = 'inactive';
        $client->save();
        return $client->delete();
    }

    public function getOne($uniq_id)
    {
        return ClientWebapp::where('uniq_id', $uniq_id);
    }

    public function getManyForExport()
    {
        return ClientWebapp::where('id', '<>', 1);
    }

    public function getMany()
    {
        return ClientWebapp::with('children')->where('id', '<>', 1)->where('child_of_id', 0);
    }
}
