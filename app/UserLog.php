<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Traits\UniqIdTrait;
use App\Contracts\UserLogInterface;

class UserLog extends Model implements UserLogInterface
{
    use UniqIdTrait;

    protected $table = 'user_logs';
    protected $hidden = ['created_at', 'updated_at'];

    public function project()
    {
        return $this->belongsTo('App\Project')->select(['uniq_id', 'name', 'id']);
    }

    public function check()
    {
        return $this->belongsTo('App\Check');
    }
}
