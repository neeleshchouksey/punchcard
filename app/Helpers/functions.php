<?php namespace App\Helpers;

class Helpers
{
    public static function isCollection($var)
    {
        return is_object($var) && preg_match('#collect#i', get_class($var));
    }
}
