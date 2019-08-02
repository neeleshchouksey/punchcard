<?php namespace App\Contracts;

use App\User;

interface ProjectsAccessUserInterface
{
    public function __construct(User $authUser);
    public function getOne($uniq_id);
    public function getMany();
    public function remove($uniq_id);
}
