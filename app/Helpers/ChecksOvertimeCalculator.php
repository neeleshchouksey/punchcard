<?php namespace App\Helpers;

use App\Helpers\Dates;

class ChecksOvertimeCalculator
{
    protected $checks;
    protected $hoursOnThisDay = [];

    public function __construct($checks)
    {
        $this->checks = $checks;
    }

    public function compile()
    {
        foreach ($this->checks as $item) {
            $dateIn  = Dates::makeDate($item->checkInDateTime);
            $dateOut = Dates::makeDate($item->checkOutDateTime);

            $this->addToDailyHours($dateIn, $dateOut);
        }

        $runningOT = 0;
        foreach ($this->hoursOnThisDay as $date => $hours) {
            // for each $date, anything greater that ihos.workDayHours
            // is "overtime"

            $runningOT += $this->calculateOvertime($hours);
        }

        return $runningOT;
    }

    protected function calculateOvertime($hours)
    {
        if ($hours <= config('ihos.workDayHours')) {
            return 0;
        }

        return $hours - config('ihos.workDayHours');
    }

    protected function addToDailyHours($dateIn, $dateOut)
    {
        $dateDiff = Dates::dateDiffHours($dateIn, $dateOut);
        $day = $dateIn->format('m/d/Y');

        if (!isset($this->hoursOnThisDay[$day])) {
            $this->hoursOnThisDay[$day] = 0;
        }

        $this->hoursOnThisDay[$day] += $dateDiff;
    }
}
