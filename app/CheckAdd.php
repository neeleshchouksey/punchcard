<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Project;
use App\Traits\UniqIdTrait;

class CheckAdd extends Check
{
    use UniqIdTrait;

    protected $table = 'checks';

    protected $fillable = [
        'user_id',
        'project_id',
        'checkInDateTime',
        'checkOutDateTime',
        'longitudeIn',
        'latitudeIn',
        'longitudeOut',
        'latitudeOut',
        'checkMethod'
    ];
}
