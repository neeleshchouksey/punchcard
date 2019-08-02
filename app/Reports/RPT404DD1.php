<?php namespace App\Reports;


// needs to be altered to be PER EMPLOYEE on Project. Just shows the drilldown for that employee
// needs to change to make the overtime calculate not just a stretch of punch in, but per day


use Auth;
use App\User;
use App\Project;
use App\Check;
use \Carbon\Carbon;

class RPT404DD1 extends ReportDataAbstract
{
    const OVERTIME_HOUR_CUTOFF = 8;
    protected $inData;

    public function __construct()
    {
        parent::__construct();
    }

    public function gather($inData)
    {
        $this->inData = $inData;

        $ret = new \StdClass;
        $ret->columns = $this->getColumns();
        $ret->inData = $inData;
        $ret->meta = $this->getMeta();
        $ret->rows = $this->getRows();

        return $ret;
    }

    public function gatherOptionData($inUser)
    {
        return __CLASS__;
    }

    protected function getColumns()
    {
        return ['PUNCH IN', 'PUNCH OUT', 'TOTAL HOURS', 'OVERTIME'];
    }

    protected function getRows()
    {
        if (!$this->inData) {
            return null;
        }

        $project = Project::where('uniq_id', $this->inData['project'])->first();
        $user = User::where('uniq_id', $this->inData['user'])->first();

        $checks = Check::with('project', 'user')
                    ->where('project_id', $project->id)
                    ->where('user_id', $user->id)
                    ->whereNotNull('checkOutDateTime')
                    ->orderBy('checkInDateTime', 'DESC');

        $checks = $this->addCheckDatesIfNecessary($checks);
        $checks = $checks->paginate(9999);

        $newChecks = $checks->map(function ($item, $key) {

            $dateIn  = $this->makeDate($item->checkInDateTime);
            $dateOut = $this->makeDate($item->checkOutDateTime);
            $dateDiff = $this->dateDiffHours($dateIn, $dateOut);
            $overtime = $this->calculateOvertime($dateDiff);
            $this->runningTotal('hours', $dateDiff);
            $this->runningTotal('overtime', $overtime);

            $ret = [
                $dateIn->format('m/d/Y h:i A'),
                $dateOut->format('m/d/Y h:i A'),
                $dateDiff,
                $overtime
            ];

            return $ret;
        });

        $newChecks[] = ['', '', $this->runningTotal('hours'), $this->runningTotal('overtime')];
        return $newChecks;
    }

    protected function calculateOvertime($hours)
    {
        if ($hours <= self::OVERTIME_HOUR_CUTOFF) {
            return 0;
        }

        return $hours - self::OVERTIME_HOUR_CUTOFF;
    }
}
