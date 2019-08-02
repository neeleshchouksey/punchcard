<?php namespace App;

use App;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;
use App\Traits\UniqIdTrait;
use Laravel\Passport\HasApiTokens;
use App\Handlers\AuthFieldTypeHandler;
use App\Exceptions\BadInputException;
use Request;
use DB;
use Log;
use App\Client;
use App\PasswordResets;
use App\SearchProjectsUsers;
use App\Notifications\RegistrationConfirmation;

class User extends Authenticatable implements CanResetPasswordContract
{
    use Notifiable, CanResetPassword, HasApiTokens, UniqIdTrait;
    use SoftDeletes;

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];

    protected $casts = [
         'jdoc' => 'array',
         'permissions' => 'array',
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'first_name', 'last_name', 'email', 'username', 'status', 'password','uniq_id', 'mobileNumber', 'jdoc'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token', 'pivot', 'created_at', 'updated_at', 'deleted_at'
    ];

    protected $appends = [
        'name'
    ];

    public $badgeLocations = [];

    public function projects()
    {
        return $this->belongsToMany('App\ProjectFull', 'project_user', 'user_id', 'project_id')->withPivot('id as badge_id');
    }

    public function activeProjects()
    {
        return $this->belongsToMany('App\ProjectFull', 'project_user', 'user_id', 'project_id')->withPivot('id as badge_id')->where('projects.status', 'active');
    }

    public function projectsWithBadgeId()
    {
        $projects = $this->projects;
        dd($projects);
    }

    public function addProjectBadges()
    {
        $projects = DB::table('project_user')
            ->join('projects', 'projects.id', '=', 'project_user.project_id')
            ->select(['projects.uniq_id'])
            ->where('project_user.user_id', $this->id)
            ->get();

        foreach ($projects as $project) {
            $this->badgeLocations[] = $this->getBadgeUrl($project->uniq_id);
        }

        $this->setAttribute('badgeLocations', $this->badgeLocations);
    }

    public function hasScannerPermission($project_id)
    {
        if (!$project_id) {
            return false;
        }

        $permissions = $this->permissions;

        if (!is_array($permissions) && !is_object($permissions)) {
            $permissions = json_decode($permissions, true);
        }

        if (! isset($permissions['scanner'])) {
            return false;
        }

        return in_array($project_id, $permissions['scanner']);
    }

    public function update(array $attributes = [], array $options = [])
    {
        parent::update($attributes);
        $this->removeFromProjectsIfNecessary();
    }

    public function delete()
    {
        parent::delete();
        $this->removeFromProjectsIfNecessary();
    }

    protected function removeFromProjectsIfNecessary()
    {
        if ($this->status == 'inactive' or $this->deleted_at !== null) {
            SearchProjectsUsers::where('user_id', $this->id)->delete();
            $this->load('projects'); // if their project list changed, we need to re-establish it
        }

        return $this;
    }

    public function updatePermission($permission, $value)
    {
        if (!$this->id) {
            return false;
        }

        if (is_array($value) || is_object($value)) {
            $value = json_encode($value);
        }

        // 2nd field can be a comma-delimited list, eg:
        // instead of scanner->foo->bar
        // scanner,foo,bar <-- Postgres speak
        // jsonb_set(field, path, new_value, boolean "create missing" default true)

        if (!sizeof($this->permissions) or empty($this->permissions)) { // the update won't work unless we at least have {}
            DB::update("UPDATE users SET permissions = '{}' WHERE id = ?", [$this->id]);
        }

        DB::update("UPDATE users
                    SET permissions = jsonb_set(permissions, '{" . $permission . "}', '" . $value . "'::jsonb)
                    WHERE id = ?", [$this->id]);

        return $this;
    }

    public function scannerPermissionAdd($project_id)
    {
        $project_id = $this->forceInt($project_id);

        if (! isset($this->permissions['scanner'])) {
            $value = [];
        } else {
            $value = $this->permissions['scanner'];
        }

        if (! is_array($value)) {
            return false;
        }

        $value[] = $project_id;

        $value = array_unique($value);

        return $this->updatePermission('scanner', $value);
    }

    public function scannerPermissionRemove($project_id)
    {
        $project_id = $this->forceInt($project_id);

        if (! isset($this->permissions['scanner'])) {
            return false;
        }

        $value = $this->permissions['scanner'];

        if (! is_array($value)) {
            return false;
        }

        $key = array_search($project_id, $value);

        if ($key !== false) {
            unset($value[$key]);
        }

        $value = array_unique($value);

        $this->updatePermission('scanner', $value);
    }

    public function checks()
    {
        return $this->hasMany('App\Check');
    }

    public function client()
    {
        return $this->belongsTo('App\Client');
    }

    public function getIsCheckedInAttribute()
    {
        $test = DB::table('checks')
            ->select(['projects.name'])
            ->join('projects', 'checks.project_id', '=', 'projects.id')
            ->where('user_id', '=', $this->id)
            ->whereNotNull('checkInDateTime')
            ->whereNull('checkOutDateTime')
            ->first();


        return isset($test->name) ? $test->name : null;
    }

    public function addOnsite($project_id)
    {
        $isOn = DB::table('checks')
            ->select(['id'])
            ->where('user_id', '=', $this->id)
            ->where('project_id', '=', $project_id)
            ->whereNotNull('checkInDateTime')
            ->whereNull('checkOutDateTime')
            ->first();

        $this->onSite = isset($isOn->id) ? true : false;
    }

    public function addLastChecks($project_id)
    {
            //->select(DB::raw('GREATEST("checkInDateTime", "checkOutDateTime") as "lastPunch"'))
        $lastIn = DB::table('checks')
            ->select(['checkInDateTime'])
            ->where('user_id', '=', $this->id)
            ->where('project_id', '=', $project_id)
            ->orderBy('checkInDateTime', 'DESC')
            ->first();

        $lastOut = DB::table('checks')
            ->select(['checkOutDateTime'])
            ->where('user_id', '=', $this->id)
            ->where('project_id', '=', $project_id)
            ->orderBy('checkOutDateTime', 'DESC')
            ->first();

        if ($lastIn) {
            $this->lastCheckIn = $lastIn->checkInDateTime;
        } else {
            $this->lastCheckIn = null;
        }

        if ($lastOut) {
            $this->lastCheckOut = $lastOut->checkOutDateTime;
        } else {
            $this->lastCheckOut = null;
        }
    }

    public function getBadgeUrl($project_uniq_id)
    {
        return '/api/v1.0/user/badge/' . $this->uniq_id . '/' . $project_uniq_id;
    }

    public function getQrUrlWithProject($project_uniq_id)
    {
        return $this->getDomainStructure() . '/api/' . env('APP_API_VERSION') .
                                             '/user/qr/' . $this->uniq_id . '/' . $project_uniq_id;
    }

    public function getNameAttribute()
    {
        return $this->first_name . ' ' . $this->last_name;
    }

    public function getAvatarAttribute()
    {
        return $this->getDomainStructure() . '/api/' . env('APP_API_VERSION') . '/user/avatar/' . $this->uniq_id;
    }

    protected function getDomainStructure()
    {
        return env('APP_SCHEME', 'http') . '://' .  $this->client->subdomain . '.' . env('WILDCARD_DOMAIN');
    }

    public function scopeActiveUser($query)
    {
        //
        // Note: SLOW, due to the random; works for testing, though.
        //
        return $query->join('clients', 'users.client_id', '=', 'clients.id')
            ->where('users.status', '=', 'active')
            ->where('users.role', '=', 'user')
            ->where('clients.status', '=', 'active')
            ->whereNull('clients.deleted_at')
            ->where('clients.child_of_id', '=', '0')
            ->orderBy(DB::raw('RANDOM()'))
            ->select(['users.*', 'clients.subdomain', 'clients.name']);
    }

    public function scopeActiveUserProject($query)
    {
        //
        // Note: SLOW, due to the random; works for testing, though.
        //
        return $query->join('clients', 'users.client_id', '=', 'clients.id')
            ->join('project_user', 'project_user.user_id', '=', 'users.id')
            ->join('projects', 'projects.id', '=', 'project_user.project_id')
            ->where('users.role', '=', 'user')
            ->where('users.status', '=', 'active')
            ->where('clients.status', '=', 'active')
            ->whereNull('clients.deleted_at')
            ->where('projects.status', '=', 'active')
            ->orderBy(DB::raw('RANDOM()'))
            ->select(['users.*', 'clients.subdomain', 'clients.name as client_name']);
    }

    public function scopeGetClean($query)
    {
        $me = $query->first();
        $jdoc = $me->jdoc;
        unset($jdoc['payroll_data']);
        $me->jdoc = $jdoc;

        return $me;
    }

    protected function forceInt($int)
    {
        return (int)preg_replace('#^0-9#', '', $int);
    }

    protected function getUserField($username)
    {
        $authFieldType = new AuthFieldTypeHandler;
        return $authFieldType->determineType($username);
    }

    public function routeNotificationForMail()
    {
        // TO send, do not include 'testing', 'local', 'dev'
        // if (!App::environment('production', 'staging')) {
        //     return env('TEST_EMAIL', 'punchcarddevelopers@gmail.com');
        // }// commented by palash

        return $this->email;
    }

    public function sendRegistrationConfirmation()
    {
        Log::info('Sending registration confirmation to ' . $this->email);

        if (!$this->email) {
            return null;
        }

        $token = PasswordResets::generate($this->email);
        $this->notify(new RegistrationConfirmation($this, $token));
    }

    public function retrieveForPasswordReset($credentials)
    {
        $parent = Client::whereSubdomain($this->getRequestSubdomain())
            ->whereActive()
            ->first();

        if ($this->invalidParent($parent)) {
            return null;
        }

        // using just the 'value' here allows for later using a mobile or username
        $possibleUsers = $this->getPossibleUsers($credentials['value'], $parent);

        if ($this->noValidUsers($possibleUsers)) {
            return null;
        }

        return $possibleUsers->first(); // really, 'user', singular
    }

    public function findForPassport($username)
    {
        $parent = Client::whereSubdomain($this->getRequestSubdomain())
            ->whereActive()
            ->first();

        if ($this->invalidParent($parent)) {
            return null;
        }

        $possibleUsers = $this->getPossibleUsers($username, $parent);

        if ($this->noValidUsers($possibleUsers)) {
            return null;
        }

        return $possibleUsers->first(); // really, 'user', singular
    }




    protected function getRequestSubdomain()
    {
        list($subdomain,) = explode('.', Request::server('HTTP_HOST'));
        $subdomain = strtolower($subdomain);

        return $subdomain;
    }

    protected function invalidParent($parent)
    {
        if (!$parent) {
            return true;
        }

        if ($parent->child_of_id <> 0) {
            //throw new BadInputException('Cannot log into child domain');
            //return \App::abort(401, 'Cannot log into child domain');
            return true;
        }
    }

    protected function getIdsToCheck($parent)
    {
        $idsToCheck = Client::where('child_of_id', $parent->id)
            ->where('status', 'active')
            ->get();

        $idsToCheck->push($parent);
        return $idsToCheck->pluck('id');
    }

    protected function getPossibleUsers($username, $parent)
    {
        $userField = $this->getUserField($username);
        return $this->where('status', 'active')
                    ->where($userField, $username)
                    ->whereIn('client_id', $this->getIdsToCheck($parent))
                    ->select('users.*')
                    ->get();
    }

    protected function noValidUsers($possibleUsers)
    {
        if ($possibleUsers == null) {
            return null;
        }

        if (sizeof($possibleUsers) == 0) {
            return null; //false;
        }

        if (sizeof($possibleUsers) > 1) {
            //throw new BadInputException('Unable to determine which parent account belongs to');
            //return \App::abort(401, 'Unable to determine which parent account belongs to');
            return null; //false;
        }
    }
}
