<?php namespace App;
use Illuminate\Database\Eloquent\Model;
use DB;

class ClientProject extends Model
{
    protected $table    = 'client_project';
    protected $fillable = ['client_id', 'project_id'];

    public function isOnProject($projectId, $clientId)
    {
        $result = DB::table($this->table)
            ->where('project_id', $projectId)
            ->where('client_id', $clientId)
            ->first();

        return sizeof($result) ? true : false;
    }

    public function client()
    {
        return $this->belongsTo('App\Client')
            ->whereNull('clients.deleted_at')
            ->where('clients.status', 'active')
            ->select(['clients.id', 'clients.uniq_id', 'clients.name']);
    }

    public static function gatherByProjectAs($project, $user)
    {
        $clientsOnProjectQuery = static::with('client')
            ->join('clients', 'clients.id', '=', 'client_project.client_id')
            ->where('client_project.project_id', $project->id)
            ->where('clients.status', 'active')
            ->whereNull('clients.deleted_at')
            ->orderBy('clients.name');

        if ($user->role <> 'clientadmin') {
            $clientsOnProjectQuery->where('client_id', $user->client_id);
        }

        return $clientsOnProjectQuery->get();
    }
}
