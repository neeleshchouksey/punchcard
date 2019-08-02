<?php namespace App\Webapp\DataImport;

class DataImportRow
{
    protected $row;

    public function __construct($row)
    {
        $this->row= $row;
    }

    protected function getValue($key)
    {
        $key = strtolower($key);
        return isset($this->row->{$key}) ? $this->row->{$key} : null;
    }

    protected function getString($key)
    {
        return (string)$this->getValue($key);
    }

    protected function abortIfNotCompatibleClientId($insertingClient, $client)
    {
        if ($insertingClient->id == $client->id) {
            return true;
        }

        if ($insertingClient->child_of_id == $client->id) {
            return true;
        }

        throw new \Exception('Cannot add data; client is not current parent or child.');
    }
}
