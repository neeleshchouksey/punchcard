<?php namespace App\Traits;

use Ramsey\Uuid\Uuid;

trait SubdomainTrait
{
    protected static function bootSubdomainTrait()
    {
        static::creating(function ($model) {
            $model->subdomain = (string)Uuid::uuid4();
        });
    }
}
