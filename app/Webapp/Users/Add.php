<?php namespace App\Webapp\Users;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;
use App\Traits\UniqIdTrait;
use App\Traits\DefaultPasswordTrait;
use App\User as AppUser;
use DB;

class Add extends AppUser
{
    protected $table = 'users';
    use Notifiable, UniqIdTrait, DefaultPasswordTrait;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'first_name', 'last_name', 'email', 'password', 'username', 'jdoc', 'mobileNumber', 'role', 'status', 'client_id'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token', 'pivot', 'created_at', 'updated_at'
    ];
}
