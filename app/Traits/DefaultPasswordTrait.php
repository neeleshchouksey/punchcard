<?php namespace App\Traits;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Hash;

trait DefaultPasswordTrait
{
    protected static function bootDefaultPasswordTrait()
    {
        static::creating(function ($model) {
            if (!isset($model->password) && empty($model->password)) {
                $model->password = Hash::make((string)Uuid::uuid4());
            }
        });
    }
}
