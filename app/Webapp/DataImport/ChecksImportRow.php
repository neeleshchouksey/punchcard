<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Illuminate\Support\Facades\Hash;
use Excel;
use App\Client;
use App\User;
use App\Project;

final class ChecksImportRow extends DataImportRow
{
    protected function getValue($key)
    {
        $key = strtolower($key);
        return isset($this->row->{$key}) ? $this->row->{$key} : null;
    }

    public function handleFor($client)
    {
        $user = User::where('uniq_id', $this->getValue('user_id'))->first();

        $clientBeingInserted = Client::find($user->client_id);

        $this->abortIfNotCompatibleClientId($clientBeingInserted, $client);

        $project = Project::where('uniq_id', $this->getValue('project_id'))->first();

        return [
            'user_id' => $user->id,
            'project_id' => $project->id,
            'checkInDateTime' => $this->getValue('checkInDateTime'),
            'checkOutDateTime' => $this->getValue('checkOutDateTime'),
            'longitudeIn' => $this->getValue('longitudeIn'),
            'latitudeIn' => $this->getValue('latitudeIn'),
            'longitudeOut' => $this->getValue('longitudeOut'),
            'latitudeOut' => $this->getValue('latitudeOut'),
            'checkMethod' => $this->getValue('checkMethod')
        ];
    }

    protected function jdoc()
    {
        return (object)[];
    }
}
