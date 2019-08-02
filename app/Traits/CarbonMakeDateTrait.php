<?php namespace App\Traits;

use Carbon\Carbon;

trait CarbonMakeDateTrait
{
    protected function makeDate($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date, 'UTC');
    }
}
