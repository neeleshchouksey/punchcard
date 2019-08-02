<?php namespace App\Webapp\Users;

use App\User;
use Auth;

class UserWebApp extends User
{
    protected $table = 'users';

    protected $fillable = [
        'first_name', 'last_name', 'email', 'username', 'status', 'password', 'mobileNumber', 'jdoc', 'role',
    ];

    public function __construct()
    {
        parent::__construct();
    }

    public static function getUser($request, $uniq_id)
    {
        $usersAccessUser = new Access(Auth::user());
        $authUser = $usersAccessUser->getAsType();
        $users = new PermittedToAccess($request, $authUser);

        $user = $users->getUser($uniq_id);

        if ($user === null) {
            return null;
        }

        $user->load('projects');
        $user->append('avatar');
        return $user;
    }
}
