<?php namespace App\Helpers;

//
// From http://stackoverflow.com/questions/10053358/measuring-the-distance-between-two-coordinates-in-php
//
class DistanceBetweenPoints
{
    const EARTH_IN_METERS = 6371000;
    const EARTH_IN_MILES  = 3959;

    private $_latitudeTo;
    private $_longitudeTo;
    private $_latitudeFrom;
    private $_longitudeFrom;

    public function __construct()
    {
    }

    public function setPoints($latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo)
    {
        $this->_latitudeTo    = $latitudeTo;
        $this->_longitudeTo   = $longitudeTo;
        $this->_latitudeFrom  = $latitudeFrom;
        $this->_longitudeFrom = $longitudeFrom;
        return $this;
    }

    public function calculate($type = 'miles', $round = -1)
    {
        $type = strtolower($type);
        switch ($type) {
            case 'meters':
            case 'meter':
                $earthRadius = self::EARTH_IN_METERS;
                break;

            default:
            case 'miles':
            case 'mile':
                $earthRadius = self::EARTH_IN_MILES;
                break;
        }

        // convert from degrees to radians
        $latFrom = deg2rad($this->_latitudeFrom);
        $lonFrom = deg2rad($this->_longitudeFrom);
        $latTo   = deg2rad($this->_latitudeTo);
        $lonTo   = deg2rad($this->_longitudeTo);

        $latDelta = $latTo - $latFrom;
        $lonDelta = $lonTo - $lonFrom;

        $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) + cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));

        $distance = $angle * $earthRadius;

        if ($round > -1) {
            return round($distance, $round);
        } else {
            return $distance;
        }
    }
}
