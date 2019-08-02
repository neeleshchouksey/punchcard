<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Illuminate\Support\Facades\Hash;
use App\Client;
use Excel;
use App\Exceptions;
use Ramsey\Uuid\Uuid;

final class ClientsImportRow extends DataImportRow
{
    public function handleFor($parent)
    {
        $row = [
            'child_of_id' => $parent->id,
            'name' => $this->getValue('name'),
            'dba' => $this->getString('dba'),
            'fein' => $this->getString('fein'),
            'address' => $this->getValue('address'),
            'city' => $this->getValue('city'),
            'state' => $this->getValue('state'),
            'zip' => $this->getValue('zip'),
            'phone' => $this->getValue('phone'),
            'fax' => $this->getValue('fax'),
            'website' => $this->getValue('website'),
            'status' => $this->getValue('status'),
//            'jdoc' => $this->jdoc()
        ];

        $subdomain = strtolower($this->getValue('subdomain'));

        if ($subdomain) {
            $row['subdomain'] = $subdomain;
        } else {
            $row['subdomain'] = (string)Uuid::uuid4();
        }

        $row['uuid'] = (string)Uuid::uuid4();

        return $row;
    }

    protected function jdoc()
    {
        return (object)[];
    }
}
