<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Excel;
use App\Client;
use App\ProjectAdd;

final class Projects extends DataImport
{
    public function handleFor($client)
    {
        $request = $this->request;
        $disk    = $this->disk;

        if (! $request->hasFile('file')) {
            return null;
        }

        $file = $request->file('file');
        $fileName = $file->store('/projects', $disk);

        $storage = Storage::disk($disk);

        if ($storage->exists($fileName)) {
            $storagePath  = $storage->getDriver()->getAdapter()->getPathPrefix();
            $loadableFile = $storagePath . $fileName;

            $import = Excel::load($loadableFile)->get();
            foreach ($import as $row) {
                $importRow = (new ProjectsImportRow($row))->handleFor($client);

                $project = new ProjectAdd($importRow);
                $newProject = $project->addTo($client);
            }
        }

        return true;
    }
}
