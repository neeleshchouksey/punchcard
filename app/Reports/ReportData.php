<?php namespace App\Reports;

class ReportData
{
    protected $report;
    protected $inData;

    public function __construct($report, $inData)
    {
        $this->report = $report;
        $this->inData = $inData;
    }

    /**
     * gather
     *
     */
    public function gather()
    {
        $filteredNumber = $this->getFilteredNumber();
        $class  = "App\Reports\\$filteredNumber";
        $report = new $class();

        if (!$report) {
            throw new \LogicException ("Report {$filteredNumber} data file not found");
        }

        $data = $this->report;
        $data->reportData = $report->gather($this->inData);
        return $data;
    }

    protected function getFilteredNumber()
    {
        return str_replace('-', '', $this->report->report_number);
    }
}
