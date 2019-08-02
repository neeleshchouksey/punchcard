<?php namespace App;

// $p = new ProjectPolyFence([25,55], 4, .02);
// $p->create();
// echo $p->retrieveAsDbInsertableString() . PHP_EOL;



class ProjectPolyFence
{
    protected $start;
    protected $num_points;
    protected $spread;
    protected $polyFence;

    public function __construct($start, $num_points, $spread)
    {
        $this->start = $start;
        $this->num_points = $num_points;
        $this->spread = $spread;
    }

    public function retrieveAsDbInsertableString()
    {
        $ret = [];
        foreach ($this->polyFence as $pF) {
            $ret[] = '(' . implode(',', $pF) . ')';
        }

        return '(' . implode(',', $ret) . ')';
    }

    public function retrieve()
    {
        return $this->polyFence;
    }

    public function create()
    {
        $long = $this->start[0];
        $lat  = $this->start[1];

        $length = $this->spread;

        //$startingPoint = [$long, $lat];
        //$points = [$startingPoint];
        $points = [$this->start];

        $points[] = [($long + $length), $lat];
        $points[] = [($long + $length), ($lat - $length)];
        $points[] = [$long, ($lat - $length)];
        //$points[] = $startingPoint;
        $points[] = $this->start;

        $this->polyFence = $points;
        return $this;
    }

    public function createRandom()
    {
        $ret = [];
        $ret[] = $this->start;

        $curLat = $this->start[0];
        $curLon = $this->start[1];

        //
        // sic, $i=1 because we self-define start/end
        //
        for ($i=1; $i<$this->num_points; $i++) {
            $newLat = $curLat += $this->spread;
            $newLon = $curLon += $this->spread;
            $point = [$newLat, $newLon];
            $ret[] = $point;
        }

        $ret[] = $this->start; // to close

        $this->polyFence = $ret;
        return $this;
    }
}
