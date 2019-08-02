<?php namespace App\Webapp;

use App\Webapp\Users\Access;
use App\Webapp\Users\PermittedToAccess;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\ProjectUser;
use Illuminate\Http\Request;
use Auth;

class StaffedOnProject
{
    use SoftDeletes;

    public function getUsers(Request $request, $project_id)
    {
        $access  = new Access(Auth::user());
        $users   = new PermittedToAccess($request, $access->getAsType());

        //
        // Get the users this user can see
        //
        $users   = $users->setColumns(['users.id'])->getManyUsers(false);

        if (! $users) {
            return null;
        }

        $userIds = $users->pluck('id');

        //
        // Get the users on this project that are in this list
        //

        $staffed = ProjectUser::join('users', 'users.id', '=', 'project_user.user_id')
            ->join('clients', 'users.client_id', '=', 'clients.id')
            ->where('project_user.project_id', $project_id)
            ->whereNull('clients.deleted_at')
            ->whereIn('users.id', $userIds->all())
            ->get([
                'users.first_name',
                'users.last_name',
                'users.uniq_id',
                'users.email',
                'users.mobileNumber',
                'users.permissions',
                'users.role',
                'clients.name as client_name',
                'clients.uniq_id as client_uniq_id'
            ]);

        return $staffed->map(function ($user) {
            $user->permissions = json_decode($user->permissions);
            return $user;
        });

        return $staffed;
    }
}
