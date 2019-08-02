<?php

namespace App\Http\Controllers;

use App\User;
use Log;
use Illuminate\Http\Request;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests;

class EmployeeController extends ApiController
{
    public function get($uniq_id = null)
    {
        $profile = User::where('uniq_id', $uniq_id)->getClean();

        if (!$profile) {
            return $this->jsonFailure("Employee not found");
        }

        $profile->addProjectBadges();
        return $this->jsonSuccess("Successfully retrieved employee profile", $profile);
    }
}
