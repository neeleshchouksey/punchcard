<?php namespace App\Traits;

use Ramsey\Uuid\Uuid;

trait UniqIdTrait
{
    protected static function bootUniqIdTrait()
    {
        static::creating(function ($model) {
            $model->uniq_id = (string)Uuid::uuid4();
        });
    }
}
