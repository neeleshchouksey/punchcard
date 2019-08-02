<?php namespace App\Webapp\Clients;

use App\User;

interface AccessInterface
{
    public function __construct(User $authUser);
    public function getOne($uniq_id);
    public function getMany();
}
