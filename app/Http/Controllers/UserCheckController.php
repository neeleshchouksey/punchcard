<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\User;
use App\Check;
use App\CheckIn;
use App\CheckOut;
use App\Project;
use App\ProjectUser;
use App\UserLog;
use Auth;
use Validator;
use App\Exceptions\BadInputException;

/**
 * Class: UserCheckController
 *
 * @see ApiController
 */
class UserCheckController extends ApiController
{
    /**
     * checkInList
     *
     */
    public function checkInList()
    {
        $checkins = Check::with('project')->where('user_id', '=', Auth::user()->id)
            ->select(
                [
                    'id',
                    'uniq_id',
                    'checkInDateTime',
                    'checkOutDateTime',
                    'project_id',
                    'user_id'
                ]
            )
            ->orderBy('checkOutDateTime', 'DESC')
            ->paginate(10);

        $checkins->map(function ($item, $key) {
            unset($item->id);
            unset($item->user_id);
            unset($item->project_id);
            unset($item->project->id);

            return $item;
        });

        return $this->respondWithJsonPagination($checkins);
    }

    /**
     * get
     *
     */
    public function get()
    {
        $checkin = new CheckIn;
        $checkinData = $checkin->isCheckedIn(Auth::user()->id);
        $num = sizeof($checkinData);
        $msg = $num ? "You are checked-in" : "You are not checked-in";
       
        return $this->jsonSuccess($msg, $checkinData);
    }

    /**
     * Check IN if:
     *  - not checked in already
     *  - if authenticated
     *
     *  if >= superuser, can check in someone else, by passing in their user uniq_id
     *
     */
     public function post(Requests\UserCheckRequest $request)
    {
        $data                = $request->all();
        $data['user_id']     = Auth::user()->id;
        $data['checkMethod'] = 'geo';

        $check   = new CheckIn;
        $project = Project::where('uniq_id', '=', $data['uniq_id'])->first();

        try {
            $check_uniq_id = $check->in($data, $project, new UserLog(), new ProjectUser());

            $data = [
                'check_uniq_id' => $check_uniq_id,
                'badge_url_visual_confirmation' => Auth::user()->getBadgeUrl($data['uniq_id'])
            ];

            return $this->jsonSuccess('checked-in', $data);
        } catch (\Exception $e) {
            return $this->jsonFailure($e->getMessage(), []);
        }
    }

    /**
     * Check OUT if:
     *  - checked in already
     *  - if authenticated
     *
     *  if >= superuser, can check out someone else, by passing in their user uniq_id
     *
     */
    public function put(Requests\UserCheckRequest $request)
    {
        $data = $request->all();
        $data['user_id'] = Auth::user()->id;
        $data['checkMethod'] = 'geo';

        $check   = CheckOut::where('user_id', '=', $data['user_id'])
            ->whereNull('checkOutDateTime')
            ->first();

        if ($check === null) {
            return $this->jsonFailure('Not checked-in', []);
        }

        $project = Project::where('uniq_id', '=', $data['uniq_id'])->first();
        $data['project_id'] = $project->id;

        try {
            $check->out($data, $project, new UserLog(), new ProjectUser());
            $data = [
                'badge_url_visual_confirmation' => Auth::user()->getBadgeUrl($data['uniq_id'])
            ];
            return $this->jsonSuccess('checked-out', $data);
        } catch (\Exception $e) {
            return $this->jsonFailure($e->getMessage(), []);
        }
    }
}
