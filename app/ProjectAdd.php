<?php namespace App;

use Ramsey\Uuid\Uuid;

class ProjectAdd extends Project
{
    protected $inData;
    protected $table = 'projects';

    /*
    protected $fillable = [
        'name',
        'description',
        'client_id',
        'sector_id',
        'industry_id',
        'startDate',
        'endDate',
        'longitude',
        'latitude',
        'radius',
        'status',
        'jdoc',
        'polyfence',
        'pointfence',
        'address',
        'city',
        'state',
        'zip',
        'county',
        'country'
    ];
    */

    public function __construct($data)
    {
        $this->inData = $data;
    }

    /**
     * Add, used by controller
     *
     */
    public function addTo($client)
    {
        $this->inData['sector_id'] = 1;
        $this->inData['industry_id'] = 1;
        $this->inData['client_id'] = $client->id;
        $this->inData['uniq_id'] = (string)Uuid::uuid4();
        $this->fill($this->inData);

        if ($this->save()) {
            $this->addClientToProject($client);
            return $this;
        }

        return false;
    }

    protected function addClientToProject($client)
    {
        return ClientProject::create([
            'project_id' => $this->id,
            'client_id' => $client->id
        ]);
    }
}
