<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use Laravel\Scout\Searchable;
use App\Traits\ProjectUserAttributesTrait;

class SearchProjectsUsers extends Model
{
    use Searchable;
    use ProjectUserAttributesTrait;

    protected $table = 'project_user';
    protected $fillable = ['project_id', 'user_id'];

    /**
     * Get the indexable data array for the model.
     *
     * @return array
     */
    public function toSearchableArray()
    {
        $this->project;
        $this->user;
        $this->user->load('client');
        $data = $this->toArray();

        //dd($data);

        $array = [
            'id' => $data['id'],
            'badge_id' => $data['id'],
            'uniq_id' => $data['user']['uniq_id'],
            'project_uniq_id' => $this->project->uniq_id,
            'user_name' => $data['user']['name'],
            'client_name' => $data['user']['client']['name'],
            'project_name' => $this->project->name,
            '"mobileNumber"' => $data['user']['mobileNumber'],
            '"licPlateNumber"' => $data['user']['jdoc']['vehicle']['licPlateNumber']
        ];

        return $array;
    }

    public function remove($data)
    {
        $project = Project::where('uniq_id', $data['project_uniq_id'])->first();
        $user    = User::where('uniq_id',    $data['user_uniq_id'])->first();

        $projectUser = static::where('project_id', $project->id)
                             ->where('user_id', $user->id)
                             ->first();

        if ($projectUser->delete()) {
            event(new \App\Events\SearchProjectUsersRemoved($projectUser));
            return true;
        }

        return false;
    }
}
