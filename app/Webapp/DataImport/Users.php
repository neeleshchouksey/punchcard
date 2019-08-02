<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Excel;
use App\Webapp\Users\Add as User;
use App\Webapp\DataImport\UsersImportRow;

final class Users extends DataImport
{
    public function handleFor($client)
    {
        $request = $this->request;
        $disk    = $this->disk;

        if (! $request->hasFile('file')) {
            return null;
        }

        $file = $request->file('file');
        $fileName = $file->store('/users', $disk);

        $storage = Storage::disk($disk);

        if ($storage->exists($fileName)) {

            $storagePath  = $storage->getDriver()->getAdapter()->getPathPrefix();
            $loadableFile = $storagePath . $fileName;

            $import = Excel::load($loadableFile)->get();

            $notAvailable = '';

            foreach ($import as $row) {

                $importRow = (new UsersImportRow($row))->handleFor($client);
                // print_r($importRow);die;
                $userInfo = User::where('email', $importRow['email'])->first();
                if(!empty($userInfo)){

                    $notAvailable .= $importRow['email'].',';
                }else{
                    
                    User::create($importRow);
                }           



            }
            return ['success'=>true, 'notAvailable'=> $notAvailable];
        }else{
            return ['success'=>true];
        }



        
    }
}
