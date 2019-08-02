<?php namespace App;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Model;
use App\Traits\UniqIdTrait;
use App\Helpers\DistanceBetweenPoints;
use DB;
use Log;

class Project extends Model
{
    use UniqIdTrait;
    use SoftDeletes;

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];



    protected $fillable = [
        'uniq_id',
        'name',
        'description',
        'client_id',
        'sector_id',
        'industry_id',
        'startDate',
        'endDate',
        'longitude',
        'latitude',
        'radius',
        'status',
        'jdoc',
        'polyfence',
        'pointfence',
        'address',
        'city',
        'state',
        'zip',
        'county',
        'country',
    ];

    public function getRouteKeyName()
    {
        return 'uniq_id';
    }

    //
    // Project "owner", the company who created and "owns" the project
    //
    public function client()
    {
        return $this->belongsTo('App\Client')->select(['uniq_id', 'name']);
    }

    //
    // Clients that have been added to the project.
    // Must be "child_of_id" clients
    //
    public function clients()
    {
        return $this->belongsToMany('App\Client', 'client_project', 'client_id', 'project_id')->withPivot('id as client_project_id');
    }


    public function checks()
    {
        return $this->hasMany('App\Check');
    }

    public function users()
    {
        return $this->belongsToMany('App\User');
    }

        // return $this->belongsToMany('App\User')
        //     ->join('clients', 'users.client_id', '=', 'clients.id')
        //     ->select(['users.*', 'project_user.*']);

    public function isWithinCheckinDistance($lat, $long)
    {
        if (! $this->radius) {

            return $this->isInsidePolyFence($lat, $long);
        } else {

            return $this->isInsideRadius($lat, $long);
        }

        return false;
    }

    protected function isInsideRadius($lat, $long)
    {
        $distance = new DistanceBetweenPoints;
        $distance->setPoints(
            $lat,
            $long,
            $this->latitude,
            $this->longitude
        );

        Log::info("User lat/lng: {$lat}/{$long}");
        Log::info("Proj lat/lng: {$this->latitude}/{$this->longitude}");
        Log::info('Fence distance/radius: ' . $distance->calculate('meters') . ' <= ' . $this->radius);
//echo ($distance->calculate('meters') <= $this->radius) ? true : false;die;
//echo $a;die;      
  return ($distance->calculate('meters') <= $this->radius) ? true : false;
    }

    public function isInsidePolyFence($lat, $long)
    {
        $data = [$this->uniq_id]; // sic!
        $sql  = 'SELECT id FROM projects WHERE "uniq_id" = ? AND "polyfence" @> POINT \'' . "($lat, $long)" . '\'';
        $result = DB::select($sql, $data);

        return $result ? true : false;
    }
}
