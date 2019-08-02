<?php namespace App\Facades;

use Illuminate\Support\Facades\Facade;

class PolygonParser extends Facade
{
    protected static $polygon;
    protected static $matches = [];

    public static function random($polygon)
    {
        self::$polygon = $polygon;
        self::init();

        shuffle(self::$matches);
        return self::$matches[0];
    }

    private static function init()
    {
        $matches = [];
        preg_match_all('#\([0-9.,-]+\)#', self::$polygon, $matches);

        foreach ($matches[0] as $match) {
            $match = str_replace('(', '', $match);
            $match = str_replace(')', '', $match);
            self::$matches[] = explode(',', $match);
        }
    }
}

// $polyfence = "((5.065495,-150.789471),(5.085495,-150.769471),(5.105495,-150.749471),(5.125495,-150.729471),(5.145495,-150.709471),(5.065495,-150.789471))";
//
// $polygonParser = new PolygonParser($polyfence);
// print_r($polygonParser->getRandom()) . PHP_EOL;
