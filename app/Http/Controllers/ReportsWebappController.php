<?php namespace App\Http\Controllers;

use Auth;
use App\UserRole;
use App\Report;
use App\Http\Requests;
use Illuminate\Http\Request;
use App\Webapp\Reports\Access;
use App\Webapp\Reports\PermittedToAccess;
use App\Webapp\Reports\ReportOptionData;
use App\Http\Requests\ReportsToggleRequest;
use App\Permissions\UserReport as UserReportPermissions;

class ReportsWebappController extends ApiController
{
    public function index(Request $request, $uniq_id = null)
    {
        $reportsAccessUser = new Access(Auth::user());
        $authUser = $reportsAccessUser->getAsType();
        $reports  = new PermittedToAccess($request, $authUser);

        if ($uniq_id) {
            $report = $reports->getReport($uniq_id);

            if ($report === null) {
                return $this->jsonDenied('No access or report not found');
            }

            return $this->jsonSuccess('Report downloaded', $report);
        }

        return $this->jsonSuccess('Reports downloaded', $reports->getManyReports(false));
    }

    public function reportData(Request $request, $uniq_id)
    {
        //$this->request = $request;

        $reportsAccessUser = new Access(Auth::user());
        $authUser = $reportsAccessUser->getAsType();
        $reports  = new PermittedToAccess($request, $authUser);

        if ($uniq_id) {
            return $this->getSingleReport($reports, $uniq_id, $request->all());
        }

        return $this->respondWithJsonPagination($reports->getManyReports());
    }

    protected function getSingleReport($reports, $uniq_id, $inData)
    {
        $report = $reports->getReportWithData($uniq_id, $inData);

        if ($report === null) {
            return $this->jsonDenied('No access');
        }

        //$report->params = $inData;
        return $this->jsonSuccess('Report downloaded', $report);
    }

    public function optionData(Request $request, $uniq_id)
    {
        $reportsAccessUser = new Access(Auth::user());
        $authUser          = $reportsAccessUser->getAsType();
        $reports           = new PermittedToAccess($request, $authUser);
        $reportOptionData  = new ReportOptionData(Auth::user());
        // print_r($reports->getReport($uniq_id));die;
        $optionData = $reportOptionData->gather($reports->getReport($uniq_id));

        return $this->jsonSuccess('Retrieved report option data', $optionData);
    }

    public function all()
    {
        $reports = Report::paginate();
        return $this->respondWithJsonPagination($reports);
    }

    public function toggle(ReportsToggleRequest $request)
    {
        $result = (new UserReportPermissions($request->all()))->handle();

        if ($result) {
            return $this->jsonSuccess($result, []);
        }

        return $this->jsonFailure('Unable to toggle report access', []);
    }
}
