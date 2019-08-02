<?php namespace App;

class UserRole
{
    protected $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }

    public function isA($level = 'user')
    {
        return $this->user->role == $level;
    }

    public function can($action, $class = null)
    {
        return $this->user->can($action, $class);
    }

    public function isAtLeast($level = 'user')
    {
        $at_least = config('roles.at_least', []);
        $accessLevels = $at_least[$level] ?: [];

        return in_array($this->user->role, $accessLevels);
    }
}
