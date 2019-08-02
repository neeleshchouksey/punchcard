<?php namespace App;

use App\Contracts\ProjectsAccessUserInterface;
//use App\ProjectsFull;

class ProjectsAccessAsSuperuser implements ProjectsAccessUserInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function remove($uniq_id)
    {
        return null;
    }

    public function getOne($uniq_id)
    {
        return ProjectFull::where('client_id', $this->authUser->client_id)
            // per Matt, will grey out in mobile app; ->where('status', 'active')
            ->where('uniq_id', $uniq_id);
    }

    public function getManyForExport()
    {
        return null;
    }

    public function getMany()
    {
        //
        // 8.3.2.1
        // The Super User should be able to view a list of all projects
        // for their own [Parent] Company which they are staffed on
        //
        return ProjectFull::join('project_user', 'projects.id', '=', 'project_user.project_id')
            // per Matt, will grey out in mobile app; ->where('status', 'active')
            ->where('project_user.user_id', $this->authUser->id);
    }
}
