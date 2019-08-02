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
 * Class: CheckBadgeWebappController
 *
 * @see ApiController
 */
class CheckBadgeWebappController extends ApiController
{
    /**
     * CheckBadgeWebappRequest is a WEBAPP ONLY validator
     * tests and allows check IN if:
     *  - if viewing user is authenticated
     *
     * CheckIn tests:
     *  - not checked in already
     */
    public function post(Requests\CheckBadgeWebappRequest $request)
    {
        try {
            $data = (new CheckBadge($request->all()))->punchIn();
            return $this->jsonSuccess('checked-in', $data);
        } catch (\Exception $e) {
            return $this->jsonFailure($e->getMessage(), []);
        }
    }

    /**
     * CheckBadgeWebappRequest tests and allows check OUT if:
     *  - if viewing user is authenticated
     *  - if viewing user has permissions
     *
     * CheckOut tests
     *
     *  - checked in already
     *
     */
    public function put(Requests\CheckBadgeWebappRequest $request)
    {
        try {
            $data = (new CheckBadge($request->all()))->punchOut();
            return $this->jsonSuccess('checked-out', $data);
        } catch (\Exception $e) {
            return $this->jsonFailure($e->getMessage(), []);
        }
    }
}
