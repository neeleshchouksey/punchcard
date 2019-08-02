<?php namespace App;

//
// For the Policy UserAdmin
//
class UserAdmin extends User
{
    protected $table = 'users';

    public function __construct()
    {
        parent::__construct();
    }

    public function scopeUniqId($query, $uniq_id)
    {
        return $query->where('uniq_id', $uniq_id)->first();
    }
}
