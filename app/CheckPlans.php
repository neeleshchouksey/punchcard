<?php namespace App;

use App;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;
use App\Traits\UniqIdTrait;
use Laravel\Passport\HasApiTokens;
use App\Handlers\AuthFieldTypeHandler;
use App\Exceptions\BadInputException;
use Request;
use DB;
use Log;
use App\Client;
use App\PasswordResets;
use App\SearchProjectsUsers;
use App\Notifications\RegistrationConfirmation;

