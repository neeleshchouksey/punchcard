<?php namespace App\Traits;

trait ProjectUserAttributesTrait
{
    public function user()
    {
        return $this->belongsTo('App\User')
            ->select([
                'users.id',
                'users.client_id',
                'users.uniq_id',
                'users.first_name',
                'users.last_name',
                'users.mobileNumber',
                'users.jdoc'
            ]);
    }

    public function project()
    {
        return $this->belongsTo('App\ProjectFull')->select(['projects.uniq_id', 'projects.name']);
    }
}
