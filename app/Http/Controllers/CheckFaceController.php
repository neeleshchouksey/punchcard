<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\User;
use App\Check;
use App\CheckFace;
use App\CheckIn;
use App\CheckOut;
use App\Project;
use App\ProjectUser;
use App\UserLog;
use App\UserBadgeData;

/**
 * Class: UserCheckController
 *
 * @see ApiController
 */
class CheckFaceController extends ApiController
{
    /**
     * CheckQrRequest is a MOBILE ONLY validator
     * tests and allows check IN if:
     *  - if viewing user is authenticated
     *  - if viewing user has permissions ('badge.punch.other') aka
     *    "scanner access"
     *
     * CheckIn tests:
     *  - not checked in already
     */
    public function post(Requests\CheckFaceRequest $request)
    {
        
        try {
            $CheckFace = new CheckFace();
            $data = $CheckFace->punchIn($request->all());

            $badgeData = new UserBadgeData($request->input('user'), $request->input('project'));
            $data['badge'] = $badgeData->get();

            return $this->jsonSuccess('checked-in', $data);
        } catch (\Exception $e) {
            return $this->jsonFailure($e->getMessage(), []);
        }
    }




    /**
     * CheckQrRequest tests and allows check OUT if:
     *  - if viewing user is authenticated
     *  - if viewing user has permissions
     *
     * CheckOut tests
     *
     *  - checked in already
     *
     */
    public function put(Requests\CheckQrRequest $request)
    {
        try {
            $checkQr = new CheckQr();
            $data = $checkQr->punchOut($request->all());

            $badgeData = new UserBadgeData($request->input('user'), $request->input('project'));
            $data['badge'] = $badgeData->get();

            return $this->jsonSuccess('checked-out', $data);
        } catch (\Exception $e) {
            return $this->jsonFailure($e->getMessage(), []);
        }
    }
}
