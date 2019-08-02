<?php namespace App\Webapp\Users;

use App\User;

interface AccessInterface
{
    public function __construct(User $authUser);
    public function getOne($uniq_id);
    public function getMany();
}
