<?php namespace App;

use Illuminate\Database\Eloquent\SoftDeletes;
use App\CheckStatsData;
use App\CheckStats;
use Illuminate\Database\Eloquent\Model;
use Auth;
//use App\Webapp\StaffedOnProject;
use Illuminate\Http\Request;

class ProjectFull extends Model
{
    use SoftDeletes;

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];

    protected $table = 'projects';
    protected $appends = ['clientloader', 'onSite', 'asType', 'logo'];
    protected $hidden = ['pivot'];

    //
    // Loading it...
    //
    public function getClientLoaderAttribute()
    {
        // don't return
        $this->client;
    }

    public function getLogoAttribute()
    {
        //return env('APP_URL') . '/api/v1.0/projects/' . $this->uniq_id . '/logo';
        return '/api/v1.0/projects/' . $this->uniq_id . '/logo';
    }

    public function getStatsAttribute()
    {
        $checkStatsData = new CheckStatsData;
        $checkStatsData->setUser(Auth::user());
        $data           = $checkStatsData->getProjectStatsData($this->id);

        $checkStats = new CheckStats($data);
        return $checkStats->getStats();
    }

    public function getOnsiteAttribute()
    {
        $onSiteUsers = Check::where('project_id', $this->id)
            ->whereNotNull('checkInDateTime')
            ->whereNull('checkOutDateTime')
            ->get(['user_id']);
            // return "palashcheck";

        return count($onSiteUsers);
    }

    public function getAsTypeAttribute()
    {
        return 'user';
    }

    //
    // Project "owner", the company who created and "owns" the project
    //
    public function client()
    {
        return $this->belongsTo('App\Webapp\Clients\ClientWebapp')->select(['uniq_id', 'name']);
    }

    //
    // Clients that have been added to the project.
    // Must be "child_of_id" clients
    //
    public function clients()
    {
        //return $this->belongsToMany('App\Webapp\Clients\ClientWebapp', 'client_project', 'project_id', 'client_id')->withPivot('id as client_project_id');
        return $this->belongsToMany('App\Webapp\Clients\ClientWebapp', 'client_project', 'project_id', 'client_id');
    }


    public function checks()
    {
        return $this->hasMany('App\Check');
    }

    //
    // Used when loading a project in the mobile app
    //
    // Except for clientadmin, should only see users in their own company
    //
    public function usersListForMobile()
    {
        $query = $this->belongsToMany('App\User', 'project_user', 'project_id', 'user_id')
                      ->where('users.status', 'active')
                      ->select('users.uniq_id', 'users.id', 'users.first_name', 'users.last_name');

        if (Auth::user()->role <> 'clientadmin') {
            $query->where('users.client_id', Auth::user()->client_id);
        }

        return $query;
    }

    //
    // All users on the project
    //
    public function users()
    {
        return $this->belongsToMany('App\User', 'project_user', 'project_id', 'user_id');
    }

    //
    // All users on the project, limited by what users the viewing user can see. For instance,
    // an 'admin' user can only see the users in his own child company.
    //
    public function getStaffedAttribute()
    {
        $staffedOnProject = new Webapp\StaffedOnProject;
        return $staffedOnProject->getUsers(new Request, $this->id);
    }
}
