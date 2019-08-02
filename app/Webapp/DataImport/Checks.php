<?php namespace App\Webapp\DataImport;

use Log;
use Storage;
use Excel;
use App\CheckAdd;
use App\User;
use App\Project;
use App\Check;
use DB;
use App\Webapp\DataImport\CheckImportRow;

final class Checks extends DataImport
{
    public function handleFor($client)
    {
        $request = $this->request;
        $disk    = $this->disk;

        if (! $request->hasFile('file')) {
            return null;
        }

        $file = $request->file('file');
        $fileName = $file->store('/checks', $disk);

        $storage = Storage::disk($disk);

        if ($storage->exists($fileName)) {
            $storagePath  = $storage->getDriver()->getAdapter()->getPathPrefix();
            $loadableFile = $storagePath . $fileName;

            $import = Excel::load($loadableFile)->get();
            foreach ($import as $row) {
                

                $dt = $row->checkindatetime;

                $checkInDate = \Carbon\Carbon::parse($dt);
                $dateCheck = $checkInDate->toDateString();
                

                $user  = User::where('uniq_id', $row->user_id)->first();
                $project  = Project::where('uniq_id', $row->project_id)->first();

                $checksCount = DB::table('checks') 
                ->where('project_id','=',$project->id)
                ->where('user_id','=',$user->id)
                ->where(DB::raw('CAST("checkInDateTime" AS date)'),'=',$dateCheck)
                ->count();

                if($checksCount == 0){
                    $importRow = (new ChecksImportRow($row))->handleFor($client);
                    CheckAdd::create($importRow);
                }

                
                
            }
        }

        return true;
    }
}
