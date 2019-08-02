<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use Storage;
use App\Webapp\Users\Access;
use App\Webapp\Users\PermittedToAccess;
use Auth;
use Illuminate\Http\Request;
use App\Traits\CarbonMakeDateTrait;

class CheckStatsData extends Check
{
    use CarbonMakeDateTrait;

    protected $table = 'checks';
    protected $authUser;

    public function setUser($authUser)
    {
        $this->authUser = $authUser;
    }

    public function getProjectStatsData($project_id)
    {
        $access  = new Access($this->authUser);
        $users   = new PermittedToAccess(new Request, $access->getAsType());
        $users   = $users->getManyUsers(false);
        $userIds = $users->pluck('id');

        //dd($users);
        return $this->join('users', 'users.id', '=', 'checks.user_id')
            ->where('project_id', $project_id)
            ->whereIn('users.id', $userIds->all())
            ->get(['checks.*', 'users.id', 'users.client_id']);
    }

    public function totalHoursByClientId($client_id, $startDate, $endDate)
    {
        //$users   = User::where('client_id', $client_id)->get(['id']);

        $rows = $this->join('users', 'users.id', '=', 'checks.user_id')
                     ->where('users.client_id', $client_id)
                     ->whereNotNull('checks.checkOutDateTime')
                     ->whereBetween('checks.checkInDateTime', [$startDate, $endDate])
                     ->get(['checks.*', 'users.id']);

        $minutesWorked = 0;
        foreach ($rows as $row) {
            $dateIn  = $this->makeDate($row->checkInDateTime);
            $dateOut = $this->makeDate($row->checkOutDateTime);

            $diffInMinutes = $dateIn->diffInMinutes($dateOut);
            $minutesWorked += $diffInMinutes;
        }

        if ($minutesWorked == 0) {
            return 0;
        }

        $hoursWorked = round($minutesWorked / 60, 2);
        return $hoursWorked;
    }

    public function totalHoursByProjectId($project_id, $startDate, $endDate)
    {
        $rows = $this->where('checks.project_id', $project_id)
                     ->whereNotNull('checks.checkOutDateTime')
                     ->whereBetween('checks.checkInDateTime', [$startDate, $endDate])
                     ->get(['checks.*']);

        $minutesWorked = 0;
        foreach ($rows as $row) {
            $dateIn  = $this->makeDate($row->checkInDateTime);
            $dateOut = $this->makeDate($row->checkOutDateTime);

            $diffInMinutes = $dateIn->diffInMinutes($dateOut);
            $minutesWorked += $diffInMinutes;
        }

        if ($minutesWorked == 0) {
            return 0;
        }

        $hoursWorked = round($minutesWorked / 60, 2);
        return $hoursWorked;
    }

    public function totalHoursByProjectAndClientId($project_id, $client_id, $startDate, $endDate)
    {
        $rows = $this->join('users', 'users.id', '=', 'checks.user_id')
                     ->where('checks.project_id', $project_id)
                     ->where('users.client_id', $client_id)
                     ->whereNotNull('checks.checkOutDateTime')
                     ->whereBetween('checks.checkInDateTime', [$startDate, $endDate])
                     ->get(['checks.*']);

        $minutesWorked = 0;
        foreach ($rows as $row) {
            $dateIn  = $this->makeDate($row->checkInDateTime);
            $dateOut = $this->makeDate($row->checkOutDateTime);

            $diffInMinutes = $dateIn->diffInMinutes($dateOut);
            $minutesWorked += $diffInMinutes;
        }

        if ($minutesWorked == 0) {
            return 0;
        }

        $hoursWorked = round($minutesWorked / 60, 2);
        return $hoursWorked;
    }

    public function totalHoursByProjectAndUserId($project_id, $user_id, $startDate, $endDate)
    {
        $rows = $this->where('checks.project_id', $project_id)
                     ->where('checks.user_id', $user_id)
                     ->whereNotNull('checks.checkOutDateTime')
                     ->whereBetween('checks.checkInDateTime', [$startDate, $endDate])
                     ->get(['checks.*']);

        $minutesWorked = 0;
        foreach ($rows as $row) {
            $dateIn  = $this->makeDate($row->checkInDateTime);
            $dateOut = $this->makeDate($row->checkOutDateTime);

            $diffInMinutes = $dateIn->diffInMinutes($dateOut);
            $minutesWorked += $diffInMinutes;
        }

        if ($minutesWorked == 0) {
            return 0;
        }

        $hoursWorked = round($minutesWorked / 60, 2);
        return $hoursWorked;
    }
    public function getProjectStatsDataForTests()
    {
        $fileName      = 'DataForClientAdminUsingWebAppZzzZzzCheckStats.json';
        $this->storage = Storage::disk('test-data');
        if ($this->storage->exists($fileName)) {
            return json_decode($this->storage->get($fileName));
        }
    }
}
