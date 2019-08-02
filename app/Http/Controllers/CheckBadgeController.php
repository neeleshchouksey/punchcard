<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\User;
use App\Check;
use App\CheckBadge;
use App\CheckIn;
use App\CheckOut;
use App\Project;
use App\ProjectUser;
use App\UserBadgeData;
use App\UserLog;

/**
 * Class: UserCheckController
 *
 * @see ApiController
 */
class CheckBadgeController extends ApiController
{
    /**
     * CheckBadgeMobileRequest is a MOBILE ONLY validator
     * tests and allows check IN if:
     *  - if viewing user is authenticated
     *  - if viewing user has permissions ('badge.punch.other') aka
     *    "scanner access"
     *
     * CheckIn tests:
     *  - not checked in already
     */
    public function post(Requests\CheckBadgeMobileRequest $request)
    {
        try {
            $data = (new CheckBadge($request->all()))->punchIn();
            return $this->jsonSuccess('checked-in', $data);
        } catch (\Exception $e) {
            $user = $request->input('user');
            return $this->jsonFailure($e->getMessage(), ['badge'=>array('name'=>$user['first_name'].' '.$user['last_name'])]);
        }
    }

    /**
     * CheckBadgeMobileRequest tests and allows check OUT if:
     *  - if viewing user is authenticated
     *  - if viewing user has permissions
     *
     * CheckOut tests
     *
     *  - checked in already
     *
     */
    public function put(Requests\CheckBadgeMobileRequest $request)
    {
        try {
            $data = (new CheckBadge($request->all()))->punchOut();
            return $this->jsonSuccess('checked-out', $data);
        } catch (\Exception $e) {
            $user = $request->input('user');
            return $this->jsonFailure($e->getMessage(), ['badge'=>array('name'=>$user['first_name'].' '.$user['last_name'])]);
        }
    }
}
