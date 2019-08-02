<?php namespace App;

use App\Webapp\Users\UserWebApp;
use Carbon\Carbon;

class Timesheets extends Check
{
    protected $table = 'checks';

    public function __construct()
    {
        parent::__construct();
    }

    public function scopeGetSheets($query, UserWebApp $user, $perPage = null)
    {
        return $query->where('user_id', $user->id)->paginate($perPage);
    }

    public static function saveCheckDateTimeChange($data, $uniq_id)
    {
        if ($data['uniq_id'] <> $uniq_id) {
            return false;
        }

        if (!in_array($data['type'], ['checkInDateTime', 'checkOutDateTime'])) {
            return false;
        }

        $check = static::with('project')->where('uniq_id', $data['uniq_id'])->first();
        $date = str_replace('+00:00', '', $data['date']);
        $date = Carbon::createFromFormat('Y-m-d H:i:s', $date, 'UTC');

        $check->{$data['type']} = $date->format('Y-m-d H:i:s');

        if ($check->save()) {
            return $check;
        } else {
            return false;
        }
    }

}
