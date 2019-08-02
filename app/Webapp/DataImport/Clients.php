<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Excel;
use App\Client;
use App\Webapp\Clients\Add as ClientAdd;
use App\Webapp\DataImport\ClientsImportRow;

final class Clients extends DataImport
{
    public function handleFor($parent)
    {
        $request = $this->request;
        $disk    = $this->disk;

        if (! $request->hasFile('file')) {
            return null;
        }

        $file = $request->file('file');
        $fileName = $file->store('/clients', $disk);

        $storage = Storage::disk($disk);

        if ($storage->exists($fileName)) {
            $storagePath  = $storage->getDriver()->getAdapter()->getPathPrefix();
            $loadableFile = $storagePath . $fileName;

            $import = Excel::load($loadableFile)->get();
            $importRows = [];
            $errors = [];

            foreach ($import as $row) {
                try {
                    $importRows[] = (new ClientsImportRow($row))->handleFor($parent);
                } catch (\Exception $e) {
                    $errors[] = $e->getMessage();
                }
            }

            if (sizeof($errors)) {
                dd($errors);
            }

            //
            // Only if no errors; add them all
            $notAvailable = '';
            foreach ($importRows as $row) {
                
                $clientBeingInserted = Client::where('fein', $row['fein'])->first();
                if(! empty($clientBeingInserted)){
                    $notAvailable .= $row['fein'].',';
                }else{
                    $row['plan_test'] = $parent['plan_test'];
                    ClientAdd::create($row);
                }
                
                
            }

            return ['success'=>true, 'notAvailable'=> $notAvailable];
        }else{
            return ['success'=>true];
        }

        return true;
    }
}
