<?php namespace App\Webapp\DataImport;


class DataImport
{
    protected $disk;
    protected $request;

    public function __construct($disk, $request)
    {
        $this->disk = $disk;
        $this->request = $request;
    }
}
