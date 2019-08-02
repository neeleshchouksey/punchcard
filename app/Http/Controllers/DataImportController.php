<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests;
use App\Client;
use App\Webapp\DataImport\Users as UserImport;
use App\Webapp\DataImport\Clients as ClientImport;
use App\Webapp\DataImport\Projects as ProjectImport;
use App\Webapp\DataImport\Checks as CheckImport;

class DataImportController extends ApiController
{
    public function users(Request $request)
    {
        $client  = Client::find(Auth::user()->client_id);
        $results = (new UserImport('dataimports', $request))->handleFor($client);

        if (! $results['success']) {
            return $this->jsonFailure('No file uploaded or import failed');
        }

        if($results['notAvailable'] == ''){
            return $this->jsonSuccess('Data successfully imported', 'Data successfully imported');
        }else{
            return $this->jsonSuccess('Data successfully imported', $results['notAvailable'].' this emailId already exist with us, other rows imported successfully');
        }
        
    }

    public function projects(Request $request)
    {
        $client  = Client::find(Auth::user()->client_id);
        $results = (new ProjectImport('dataimports', $request))->handleFor($client);

        if (! $results) {
            return $this->jsonFailure('No file uploaded or import failed');
        }

        return $this->jsonSuccess('Data successfully imported', 'File Imported');
    }

    public function checks (Request $request)
    {
        $client  = Client::find(Auth::user()->client_id);
        $results = (new CheckImport('dataimports', $request))->handleFor($client);

        if (! $results) {
            return $this->jsonFailure('No file uploaded or import failed');
        }

        return $this->jsonSuccess('Data successfully imported', 'File Imported');
    }

    public function clients(Request $request)
    {
        $parent  = Client::where('uniq_id', $request->input('uniq_id'))->first();
        $results = (new ClientImport('dataimports', $request))->handleFor($parent);

        if (! $results['success']) {
            return $this->jsonFailure('No file uploaded or import failed');
        }
        if($results['notAvailable'] == ''){
            return $this->jsonSuccess('Data successfully imported', 'Data successfully imported');
        }else{
            return $this->jsonSuccess('Data successfully imported', $results['notAvailable'].'this FIEN already exist with us, other rows imported successfully');
        }
        
    }
}
