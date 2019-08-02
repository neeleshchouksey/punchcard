<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class PasswordResets extends Model
{
    protected $fillable = ['email', 'token'];
    public $primaryKey  = 'email';
    public $timestamps = false;

    public static function boot()
    {
        static::creating(function ($model) {
            $model->setCreatedAt($model->freshTimestamp());
        });
    }

    public static function generate($email)
    {
        $token = static::makeToken();
        $created = static::create(['email' => $email, 'token' => $token]);

        if (!$created) {
            return null;
        }

        return $token;
    }

    protected static function makeToken()
    {
        $hashKey = env('APP_KEY');
        return hash_hmac('sha256', Str::random(40), $hashKey);
    }
}
