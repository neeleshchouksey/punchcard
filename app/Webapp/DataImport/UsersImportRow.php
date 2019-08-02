<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Illuminate\Support\Facades\Hash;
use Excel;
use App\Client;
use App\Webapp\DataImport\UsersImportRow;

final class UsersImportRow extends DataImportRow
{
    public function handleFor($client)
    {
        // echo $this->getString('client_id');die;
        $clientBeingInserted = Client::where('uniq_id', $this->getString('client_id'))->first();
        // print_r($clientBeingInserted);die;
        $this->abortIfNotCompatibleClientId($clientBeingInserted, $client);

        return [
            'first_name' => $this->getValue('first_name'),
            'last_name' => $this->getValue('last_name'),
            'email' => $this->getValue('email'),
            'password' => $this->getPassword(),
            'client_id' => $clientBeingInserted->id,
            'mobileNumber' => $this->getString('mobilenumber'), // Excel lowers everything for some reason
            'role' => $this->getValue('role'),
            'status' => $this->getValue('status'),
            'username' => $this->getValue('username'),
            'jdoc' => $this->jdoc()
        ];
    }

    protected function getPassword()
    {
        $password = $this->getValue('password');

        if (!$password) {
            $password = Hash::make($this->getValue('email'));
        }

        return $password;
    }

    protected function jdoc()
    {
        return (object)[
                "department" => $this->getValue('jdoc_department'),
                "homeNumber" => $this->getValue('jdoc_homeNumber'),
                "job_title" => $this->getValue('jdoc_job_title'),
                "middleName" => $this->getValue('jdoc_middleName'),
                "trade" => $this->getValue('jdoc_trade'),
                "workNumber" => $this->getValue('jdoc_workNumber'),
                "primaryAddress" => (object)[
                    "address1" => $this->getValue('jdoc_primary_address_address1'),
                    "address2" => $this->getValue('jdoc_primary_address_address2'),
                    "city" => $this->getValue('jdoc_primary_address_city'),
                    "state" => $this->getValue('jdoc_primary_address_state'),
                    "zip" => $this->getValue('jdoc_primary_address_zip'),
                ],
                "secondaryAddress" => (object)[
                    "address1" => $this->getValue('jdoc_secondry_address_address1'),
                    "address2" => $this->getValue('jdoc_secondry_address_address2'),
                    "city" => $this->getValue('jdoc_secondry_address_city'),
                    "state" => $this->getValue('jdoc_secondry_address_state'),
                    "zip" => $this->getValue('jdoc_secondry_address_zip'),
                ],
                "vehicle" => (object)[
                    "carMake" => $this->getValue('jdoc_vehicle_carMake'),
                    "carModel" => $this->getValue('jdoc_vehicle_carModel'),
                    "driversLicenseNumber" => $this->getValue('jdoc_vehicle_driversLicenseNumber'),
                    "driversLicenseState" => $this->getValue('jdoc_vehicle_driversLicenseState'),
                    "licPlateNumber" => $this->getValue('jdoc_vehicle_licPlateNumber'),
                    "licPlateState" => $this->getValue('jdoc_vehicle_licPlateState')
                ],
                "emerContact" => (object)[
                    "email" => $this->getValue('jdoc_emerContact_email'),
                    "homeNumber" => $this->getValue('jdoc_emerContact_homeNumber'),
                    "mobileNumber" => $this->getValue('jdoc_emerContact_mobileNumber'),
                    "name" => $this->getValue('jdoc_emerContact_name'),
                    "relation" => $this->getValue('jdoc_emerContact_relation'),
                    "workNumber" => $this->getValue('jdoc_emerContact_workNumber'),
                ],
                "scheduling" => (object)[
                    "payPeriod" => $this->getValue('jdoc_scheduling_payPeriod'),
                    "paySchedule" => $this->getValue('jdoc_scheduling_paySchedule'),
                    "dailyEndTime" => $this->getValue('jdoc_scheduling_dailyEndTime'),
                    "workWeekStart" => $this->getValue('jdoc_scheduling_workWeekStart'),
                    "dailyStartTime" => $this->getValue('jdoc_scheduling_dailyStartTime'),
                    "lunchTimeAmount" => $this->getValue('jdoc_scheduling_lunchTimeAmount'),
                ],
                "payroll_data" => (object)[
                    "pay_rate" => $this->getValue('jdoc_payroll_data_pay_rate'),
                    "rate" => $this->getValue('jdoc_payroll_data_rate'),
                    "state" => $this->getValue('jdoc_payroll_data_state'),
                    "expModifier" => $this->getValue('jdoc_payroll_data_expModifier'),
                    "wcGocClassCode" => $this->getValue('jdoc_payroll_data_wcGocClassCode'),
                    "estimatedPremium" => $this->getValue('jdoc_payroll_data_estimatedPremium'),
                    "estimatedHoursMonth" => $this->getValue('jdoc_payroll_data_estimatedHoursMonth'),
                ],
                "demographics" => (object)[
                    "sex" => $this->getValue('jdoc_demographics_sex'),
                    "ethnicity" => $this->getValue('jdoc_demographics_ethnicity'),
                    "drugTestDate" => $this->getValue('jdoc_demographics_drugTestDate'),
                    "drugTestResult" => $this->getValue('jdoc_demographics_drugTestResult'),
                    "backgroundCheckDate" => $this->getValue('jdoc_demographics_backgroundCheckDate'),
                    "backgroundCheckResult" => $this->getValue('jdoc_demographics_backgroundCheckResult'),
                ],
        ];
    }
}
