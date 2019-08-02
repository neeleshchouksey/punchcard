<?php namespace App;

use App\ProjectUser;

class UserBadgeData
{
    protected $user;
    protected $project;

    public function __construct($user, $project)
    {
        $this->user = $user;
        $this->project = $project;
    }

    public function get()
    {
        if (! $this->user) {
            return false;
        }

        if (! $this->project) {
            return false;
        }

        $projectUser = ProjectUser::where('user_id', $this->user->id)
                                        ->where('project_id', $this->project->id)
                                        ->first();

        if (! $projectUser) {
            return false;
        }

        return [
            'name' => $this->user->name,
            'badge_id' => $projectUser->id,
            'client_name' => $this->user->client->name,
            'project_name' => $this->project->name,
            'project_address' => array('address'=> $this->project->address, 'city'=> $this->project->city, 'state'=> $this->project->state, 'zip'=> $this->project->zip, 'country'=> $this->project->country),
            'avatar_location' => $this->user->avatar,
            'qr_location' => $this->user->getQrUrlWithProject($this->project->uniq_id),
        ];
    }
}
