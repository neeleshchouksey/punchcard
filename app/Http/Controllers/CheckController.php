<?php namespace App\Http\Controllers;

use Auth;
#use Validator;
use Illuminate\Support\Facades\Validator;
use Request;
use App\User;
use App\ProjectFull;
use App\Http\Requests\ScannerToggleRequest;
use App\Permissions\Scanner as ScannerPermissions;

class CheckController extends ApiController
{
    public function scannerToggle(ScannerToggleRequest $request)
    {
        $result = (new ScannerPermissions($request->all()))->handle();

        if ($result) {
            return $this->jsonSuccess($result, []);
        }

        return $this->jsonFailure('Unable to toggle scanner access', []);

        // $user    = User::where('uniq_id', '=', Request::input('user_uniq_id'))->first();
        // $project = ProjectFull::where('uniq_id', '=', Request::input('project_uniq_id'))->first();
        //
        // if ($user->hasScannerPermission($project->id)) {
        //     $user->scannerPermissionRemove($project->id);
        //     return 'removed';
        // }
        //
        // $user->scannerPermissionAdd($project->id);
        // return 'added';
    }
}
