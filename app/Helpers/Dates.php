<?php namespace App\Helpers;

use \Carbon\Carbon;

class Dates extends Carbon
{
    public static function dateDiffHours($dateIn, $dateOut)
    {
        if ($dateIn == null || $dateOut == null) {
            return 0;
        }

        return static::minutesToHours($dateIn->diffInMinutes($dateOut));
    }

    public static function minutesToHours($minutes)
    {
        if (!$minutes or $minutes <= 0) {
            return 0;
        }

        return round(($minutes / 60), 2);
    }

    public static function makeDate($date)
    {
        if ($date == null) {
            return null;
        }

        return static::createFromFormat('Y-m-d H:i:s', $date, 'UTC');
    }
}
