<?php namespace App\Permissions;

use App\UserPermissions;
use App\Project;

class Scanner
{
    protected $inData;
    protected $permission = 'scanner';

    public function __construct($inData)
    {
        $this->inData = $inData;
    }

    public function handle()
    {
        $user    = UserPermissions::where('uniq_id', '=', $this->inData['user_uniq_id'])->first();
        $project = Project::where('uniq_id', '=', $this->inData['project_uniq_id'])->first();

        $user->updateArrayPermission($this->permission, $this->inData['data']);

        return 'updated';
    }
}
