<?php namespace App\Helpers;

class PolyFenceHelper
{
    protected $polyfence;

    public function __construct($polyfence)
    {
        $this->polyfence = $polyfence;
    }

    public function getPosition()
    {
        $pos = strpos($this->polyfence, ')');
        $sub = substr($this->polyfence, 0, $pos);
        $sub = preg_replace('#[^-,.0-9]#', '', $sub);
        return explode(',', $sub);
    }
}
