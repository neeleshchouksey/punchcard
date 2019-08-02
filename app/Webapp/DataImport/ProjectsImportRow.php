<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Illuminate\Support\Facades\Hash;
use Excel;

final class ProjectsImportRow extends DataImportRow
{
    protected function getValue($key)
    {
        $key = strtolower($key);
        return isset($this->row->{$key}) ? $this->row->{$key} : null;
    }

    public function handleFor($client)
    {
        return [
            'name' => $this->getValue('name'),
            'description' => $this->getValue('description'),
            'sector_id' => $this->getValue('sector_id'),
            'industry_id' => $this->getValue('industry_id'),
            'startDate' => $this->getValue('startDate'),
            'endDate' => $this->getValue('endDate'),
            'longitude' => $this->getValue('longitude'),
            'latitude' => $this->getValue('latitude'),
            'radius' => $this->getValue('radius'),
            'polyfence' => $this->getValue('polyfence'),
            'pointfence' => $this->getValue('pointfence'),
            'address' => $this->getValue('address'),
            'city' => $this->getValue('city'),
            'state' => $this->getValue('state'),
            'zip' => $this->getValue('zip'),
            'county' => $this->getValue('county'),
            'country' => $this->getValue('country'),
            'status' => $this->getValue('status')
        ];
    }

    protected function jdoc()
    {
        return (object)[];
    }
}
