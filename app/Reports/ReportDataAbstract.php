<?php namespace App\Reports;

use App\Helpers\Dates;

abstract class ReportDataAbstract
{
    protected $runningTotalData = [];

    public function __construct()
    {
    }

    abstract public function gather($inData);
    abstract public function gatherOptionData($inUser);

    protected function runningTotal($key = 'default', $diff = null)
    {
        if ($diff === null) {
            return isset($this->runningTotalData[$key]) ? $this->runningTotalData[$key] : 0;
        }

        if (!isset($this->runningTotalData[$key])) {
            $this->runningTotalData[$key] = 0;
        }

        $this->runningTotalData[$key] += $diff;
    }

    protected function dateDiffHours($dateIn, $dateOut)
    {
        return Dates::dateDiffHours($dateIn, $dateOut);
    }

    protected function makeDate($date)
    {
        return Dates::makeDate($date);
    }

    protected function addCheckDatesIfNecessary($checks)
    {
        if (isset($this->inData['startDate']) && $this->inData['startDate']) {
            $checks->where('checkInDateTime', '>', $this->inData['startDate'] . ' 00:00:00');
        }

        if (isset($this->inData['endDate']) && $this->inData['endDate']) {
            $checks->where('checkInDateTime', '<', $this->inData['endDate'] . ' 23:59:59');
        }

        return $checks;
    }
    protected function getMeta()
    {
        return [];
    }
}
