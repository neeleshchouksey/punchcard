<?php namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Traits\CarbonMakeDateTrait;

class CheckStats extends Check
{
    use CarbonMakeDateTrait;

    protected $table = 'checks';

    protected $data;
    protected $stats = [
        'daysWorked' => [],
        'minutesWorked' => 0,
        'employeesOnSite' => 0,
        'companiesOnSite' => []
    ];

    public function __construct($data = null)
    {
        $this->data = $data;
    }

    public function getStats()
    {
        //dd($this->data);
        foreach ($this->data as $row) {
            $this->handle($row);
        }

        //return $this->stats;

        return [
            'daysWorked' => sizeof($this->stats['daysWorked']),
            'hoursWorked' => $this->hoursWorked(),
            'employeesOnSite' => $this->employeesOnSite(),
            'companiesOnSite' => $this->companiesOnSite()
        ];
    }

    protected function hoursWorked()
    {
        return round($this->stats['minutesWorked'] / 60, 2);
    }

    protected function daysWorked()
    {
        return sizeof($this->stats['daysWorked']);
    }

    protected function employeesOnSite()
    {
        return $this->stats['employeesOnSite'];
    }

    protected function companiesOnSite()
    {
        return sizeof($this->stats['companiesOnSite']);
    }

    protected function handle($row)
    {
        $this->handleTotalDaysWorked($row);
        $this->handleTotalHoursWorked($row);
        $this->handleEmployeesOnSite($row);
        $this->handleCompaniesOnSite($row);
    }

    protected function handleTotalDaysWorked($row)
    {
        $date = $this->makeDate($row->checkInDateTime);

        if (! isset($this->stats['daysWorked'][$date->toDateString()])) {
            $this->stats['daysWorked'][$date->toDateString()] = 0;
        }

        $this->stats['daysWorked'][$date->toDateString()]++;
    }

    protected function handleTotalHoursWorked($row)
    {
        if ($row->checkInDateTime == null or $row->checkOutDateTime == null) {
            return;
        }

        $dateIn  = $this->makeDate($row->checkInDateTime);
        $dateOut = $this->makeDate($row->checkOutDateTime);

        $diffInMinutes = $dateIn->diffInMinutes($dateOut);
        $this->stats['minutesWorked'] += $diffInMinutes;
    }

    protected function handleEmployeesOnSite($row)
    {
        if ($row->checkOutDateTime == null)
        {
            $this->stats['employeesOnSite']++;
        }
    }

    protected function handleCompaniesOnSite($row)
    {
        if ($row->checkOutDateTime <> null)
        {
            return;
        }

        if (! isset($this->stats['companiesOnSite'][$row->client_id])) {
            $this->stats['companiesOnSite'][$row->client_id] = 0;
        }

        $this->stats['companiesOnSite'][$row->client_id]++;
    }
}
