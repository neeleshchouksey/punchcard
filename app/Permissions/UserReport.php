<?php namespace App\Permissions;

use App\UserPermissions;
use App\Report;

class UserReport
{
    protected $inData;
    protected $permission = 'reports';

    public function __construct($inData)
    {
        $this->inData = $inData;
    }

    public function handle()
    {

        $user    = UserPermissions::where('uniq_id', '=', $this->inData['user_uniq_id'])->first();
        $report  = Report::where('uniq_id', '=', $this->inData['report_uniq_id'])->first();

        $user->updateArrayPermission($this->permission, $this->inData['data']);

        return 'updated';

        // if ($user->hasPermission($this->permission, $report->id)) {
        //     $user->permissionRemove($this->permission, $report->id);
        //     return 'removed';
        // }
        //
        // $user->permissionAdd($this->permission, $report->id);
        //
        // return 'added';
    }
}
