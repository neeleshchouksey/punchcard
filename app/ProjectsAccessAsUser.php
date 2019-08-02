<?php namespace App;

use App\Contracts\ProjectsAccessUserInterface;
//use App\ProjectsFull;

class ProjectsAccessAsUser implements ProjectsAccessUserInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getOne($uniq_id)
    {
        return ProjectFull::where('client_id', $this->authUser->client_id)
            // per Matt, will grey out in mobile app; ->where('status', 'active')
            ->where('uniq_id', $uniq_id);
    }

    public function remove($uniq_id)
    {
        return null;
    }

    public function getManyForExport()
    {
        return null;
    }

    public function getMany()
    {
        //
        // 9.3.2.1 Parent Company Users
        // 9.3.2.1.1 The User should be able to view a list of all projects for their
        //  own [Parent] Company projects which they have been staffed on
        // 9.3.2.2 Child Company Users
        // 9.3.2.2.1 The User should be able to view a list of all projects for their
        //  own [Child] Company which they have been staffed on
        //
        // Clarification: from slack on 12/5/2016. A 'user' should see projects they are staffed on where
        // the projects are from the Parent company. The child company has no projects.
        //
        // Thus: select from project_user where they are staffed
        //
        return ProjectFull::join('project_user', 'projects.id', '=', 'project_user.project_id')
                // per Matt, will grey out in mobile app; ->where('status', 'active')
                  ->where('project_user.user_id', $this->authUser->id);
    }
}
