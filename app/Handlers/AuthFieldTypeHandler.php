<?php namespace App\Handlers;

class AuthFieldTypeHandler
{
    protected function isEmail($user)
    {
        return strpos($user, '@');
    }

    protected function isPhone($user)
    {
        $user = preg_replace('#[^0-9]+#', '', $user);
        return (strlen($user) >= 10) ? true : false;
    }

    public function determineType($user)
    {
        if ($this->isEmail($user)) {
            return 'email';
        }

        if ($this->isPhone($user)) {
            return 'mobileNumber';
        }

        return 'username';
    }
}
