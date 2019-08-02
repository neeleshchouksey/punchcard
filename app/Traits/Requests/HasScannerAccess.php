<?php namespace App\Traits\Requests;

use App\Check;
use App\UserRole;
use App\User;
use App\Exceptions;
use Auth;

trait HasScannerAccess
{
    protected function hasScannerAccess($project, $user, $data)
    {
        if (! Auth::user()->id) {
            return false;
        }

        //  viewing user, the one who is checking in the other person
        //  by scanning their QR code, must have this special permission
        //  to check in others

        if (! Auth::user()->hasScannerPermission($project->id)) {
            $this->errorMsg[] = "In hasScannerAccess(), Currently logged in user does not have 'scanner' permission to project {$project->uniq_id}";
            return false;
        }

        // viewing user, the one who is checking in the other person
        // by scanning their QR code, must already be checked in to the
        // project

        if (! Check::isCheckedInTo(Auth::user(), $project)) {
            $this->errorMsg[] = "In hasScannerAccess(), Currently logged in user is not already checked in to project {$project->uniq_id}";
            return false;
        }

        return true;
    }
}
