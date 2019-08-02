<?php namespace App\Webapp\Reports;

use App\User;

class AccessAsClientadmin implements AccessInterface
{
    protected $authUser;

    public function __construct(User $authUser)
    {
        $this->authUser = $authUser;
    }

    public function getOne($uniq_id)
    {
        return ReportWebapp::where("permissions->clientadmin", 'true')->where('uniq_id', $uniq_id);
    }

    public function getMany()
    {
        return ReportWebapp::where("permissions->clientadmin", 'true');
    }
}
