<?php namespace App\Webapp\DataExport;

use Illuminate\Http\Request;
use App\Webapp\Clients\Access as ClientsAccess;
use App\Webapp\Clients\PermittedToAccess as ClientsPermittedToAccess;
use App\Webapp\Users\Access as UsersAccess;
use App\Webapp\Users\PermittedToAccess as UsersPermittedToAccess;
use App\ProjectsAccessUser as ProjectsAccess;
use App\ProjectsUserPermittedToAccess as ProjectsPermittedToAccess;
use Excel;
use App\Check;

class DataExportBulk
{
    protected $inData;

    public function __construct($inData)
    {
        $this->inData = $inData;
    }

    public function handleFor($viewingUser)
    {
        $authClient  = (new ClientsAccess($viewingUser))->getAsType();
        $clients     = new ClientsPermittedToAccess(new Request, $authClient);

        $authUser    = (new UsersAccess($viewingUser))->getAsType();
        $users       = new UsersPermittedToAccess(new Request, $authUser);

        $authProject = (new ProjectsAccess($viewingUser))->getAsType();
        $projects    = new ProjectsPermittedToAccess(new Request, $authProject);
        $usersToExport = $users->getManyUsersForExport();

        $checksToExport   = Check::whereIn('user_id', $usersToExport->pluck('id'))->get();

        $zip = new \ZipStream\ZipStream('bulk-export.zip',['content_type' => 'application/x-zip']);
            $zip->addFile('clients.csv', $this->makeCsv($clients->getManyClientsForExport(), ['jdoc']));
            $zip->addFile('users.csv', $this->makeCsv($usersToExport, ['permissions', 'jdoc']));
            $zip->addFile('projects.csv', $this->makeCsv($projects->getManyProjectsForExport(), ['jdoc']));

            $zip->addFile('checks.csv', $this->makeCsv($checksToExport));
        $zip->finish();
    }

    protected function flattenJson($key, $jsonField)
    {
        if (is_object($key) && is_array($key->{$jsonField}) && sizeof($key->{$jsonField})) {
            $dotted = array_dot([$jsonField => $key->{$jsonField}]);
            $underscored = [];

            foreach ($dotted as $dkey => $value) {
                $dkey = str_replace('.', '_', $dkey);

                if (is_array($value) or is_object($value)) {
                    $value = json_encode($value);
                }

                $underscored[$dkey] = $value;
            }

            foreach ($underscored as $k => $v) {
                $key->{$k} = $v;
            }
        }

        return $key;
    }

    protected function getRows($data, $jsonFields = [], $except = [])
    {
        $jdocFlattened = $data->map(function ($key, $item) use ($jsonFields, $except) {
            foreach ($jsonFields as $jsonField) {
                $key = $this->flattenJson($key, $jsonField);
            }

            $except = array_merge($except, $jsonFields);

            foreach ($except as $ex) {
                if (isset($key[$ex])) {
                    unset($key[$ex]);
                }
            }

            return $key;
        });

        return $jdocFlattened->toArray();
    }

    protected function getColumns($data)
    {
        if (!isset($data[0]) or !is_array($data[0])) {
            return [];
        }

        foreach ($data[0] as $key => $val) {
            if (is_array($val)) {
                continue;
            }

            $header[] = '"' . $key . '"';
        }

        return $header;
    }

    protected function makeCsv($data, $jsonFields = [], $except = [])
    {
        if (!$data) {
            return;
        }

        $rows    = $this->getRows($data, $jsonFields, $except);
        $columns = $this->getColumns($rows);

        $csv = [];
        $csv[] = implode(',', $columns);

        foreach ($rows as $row) {
            $line = [];
            foreach ($row as $key => $val) {
                if (is_array($val)) {
                    continue;
                }

                $line[] = '"' . $val . '"';
            }

            $csv[] = implode(',', $line);
        }

        return implode(PHP_EOL, $csv);
    }
}
