<?php namespace App\Webapp\Clients;

use App\Client;

class ClientWebApp extends Client
{
    protected $appends = ['logo'];
    protected $table = 'clients';

    public function __construct()
    {
        parent::__construct();
    }

    public function children()
    {
        return $this->hasMany('App\Webapp\Clients\ClientWebApp', 'child_of_id', 'id');
    }
}
