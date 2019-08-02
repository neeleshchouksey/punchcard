<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;
use App\Traits\ProjectUserAttributesTrait;

class ProjectUser extends Model
{
    use ProjectUserAttributesTrait;

    protected $table = 'project_user';
    protected $fillable = ['project_id', 'user_id'];

    public function isOnProject($projectId, $userId)
    {
        $result = DB::table($this->table)
            ->where('project_id', $projectId)
            ->where('user_id', $userId)
            ->first();

        return sizeof($result) ? true : false;
    }
}
