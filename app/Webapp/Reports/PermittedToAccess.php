<?php namespace App\Webapp\Reports;

use Log;
use Auth;
use App\User;
use App\Reports\ReportData;
use Illuminate\Http\Request;

class PermittedToAccess
{
    protected $inRequest;
    protected $inUser;
    //protected $select = ['*'];

    public function __construct(Request $request, AccessInterface $authUser)
    {
        $this->inRequest = $request;
        $this->inUser = $authUser;
    }

    public function getReport($uniq_id)
    {
        $as = $this->inUser->getOne($uniq_id);

        if (!$as) {
            return null;
        }

        return $as->select(['*'])->first();
    }

    public function getReportWithData($uniq_id, $inData)
    {
        $report = $this->getReport($uniq_id);

        if (!$report) {
            return null;
        }

        $data   = (new ReportData($report, $inData))->gather();

        return $data;
    }

    public function getManyReports($paginated = true)
    {
        //
        // Slightly different than others. Here, if the user has permissions to a subset,
        // we want to return those. Otherwise, we return the default set for their user-type
        //
        if ($this->doesHaveReportPermissionsSet()) {
            $as = $this->getPermittedReports();
        } else {
            $as = $this->inUser->getMany();
        }

        if (!$as) {
            return null;
        }

        if ($paginated) {
            return $as->select(['*'])->orderBy('report_number')->paginate($this->inRequest->query('per_page', 10));
        } else {
            return $as->select(['*'])->orderBy('report_number')->get();
        }
    }

    protected function doesHaveReportPermissionsSet()
    {
        $reportsPermitted = $this->getPermittedReportIds();
        return sizeof($this->getPermittedReportIds());
    }

    protected function getPermittedReports()
    {
        $reportsPermitted = $this->getPermittedReportIds();
        return ReportWebapp::whereIn('id', $reportsPermitted);
    }

    protected function getPermittedReportIds()
    {
        return isset(Auth::user()->permissions['reports']) ? Auth::user()->permissions['reports'] : [];
    }
}
