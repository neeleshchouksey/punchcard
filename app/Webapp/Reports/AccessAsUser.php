<?php namespace App\Webapp\Reports;

use App\User;

class AccessAsUser implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getOne($uniq_id)
    {
        return ReportWebapp::where("permissions->user", 'true')->where('uniq_id', $uniq_id);
    }

    public function getMany()
    {
        return ReportWebapp::where("permissions->user", 'true');
    }
}
