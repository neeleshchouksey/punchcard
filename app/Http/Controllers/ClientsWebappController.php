<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use Auth;
use App\Client;
use App\User;
use App\ProjectUser;
use App\ClientProject;
use App\Webapp\Clients\StoreLogo;
use App\Webapp\Clients\Add as ClientAdd;
use App\Webapp\Clients\Update as ClientUpdate;
use App\Webapp\Clients\Access;
use App\Webapp\Clients\PermittedToAccess;
use App\Http\Requests\WebappClientPutRequest;
use App\Http\Requests\WebappClientPostRequest;
use App\Http\Requests\WebappClientParentPostRequest;
use App\Http\Requests\WebappClientContactRequest;
use DB;

class ClientsWebappController extends ApiController
{
    public function addContact(WebappClientContactRequest $request)
    {
        $client = Client::where('uniq_id', $request->input('uniq_id'))->first();
        $result = $client->addContact($request->input('data'));

        if (!is_array($result)) {
            return $this->jsonFailure('Cannot add contact');
        }

        return $this->jsonSuccess('Contact added', $result);
    }

    public function removeContact(Request $request)
    {
        $client = Client::where('uniq_id', $request->input('uniq_id'))->first();
        $result = $client->removeContact($request->input('id'));

        if (!is_array($result)) {
            return $this->jsonFailure('Cannot remove contact');
        }

        return $this->jsonSuccess('Contact removed', $result);
    }

    public function index(Request $request, $uniq_id = null)
    {
        $access  = new Access(Auth::user());
        $clients = new PermittedToAccess($request, $access->getAsType());

        if (! $uniq_id) {
            $clientData = $clients->getManyClients()->toArray();
           
            $newClientdata = array();
            foreach ($clientData['data'] as $cl) {
                $client_id = $cl['id'];
                $cl['totalActiveUsers'] = DB::table('users') 
                      ->select('id') 
                      ->where('status','=','active')            
                      ->whereIn('client_id',function($query) use ($client_id){ 
                            $query->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);            
                       })        
                      ->count();
                $lastActive = DB::table('checks') 
                    ->select('checks.user_id as uid','checks.id as cid','checks.checkInDateTime as checkInDateTime')            
                    ->whereIn('user_id',function($query) use ($client_id){               
                       $query->select('id')->from('users')->whereIn('client_id',function($query2) use ($client_id){               
                          $query2->select('id')->from('clients')->where('id','=',$client_id)->orWhere('child_of_id','=',$client_id);
                        });
                     })
                    ->orderBy('cid','Desc')
                    ->limit(1)
                    ->get(); 
                    $lastActiveDate  = "";
                if(count($lastActive) >0){
                    $lastActiveDate = $lastActive[0]->checkInDateTime;

                }else{
                    $lastActiveDate = 'Not CheckedIn Yet';
                }
                $cl['lastActiveDate'] = $lastActiveDate;
                 $newClientdata[] = $cl;            
            }
            $clientData['data'] = $newClientdata;
            return $this->respondWithJsonPaginationForClients($clientData);
            //return $this->respondWithJsonPagination($clients->getManyClients());
        }

        $client = $clients->getClient($uniq_id);

        if (! $client) {
            return $this->jsonNotFound("Client {$uniq_id} not found or not accessible by current user");
        }

        $client->load('users');
        $client->load('projects');
        $client->load('children');
        $client->append('logo');

        return $this->jsonSuccess("Showing client", $client);
    }


    public function put(WebappClientPutRequest $request)
    {
        
        if($request->input('status') == 'inactive'){

            $client  = Client::where('uniq_id', $request->input('uniq_id'))->first();
            $cp = ClientProject::where('client_id', $client->id)->get();

            foreach($cp as $val){

                if ($val->delete()) {
                $usersInClient = User::where('client_id', $client->id)->select(['id'])->get();
                $userIdsToRemove = $usersInClient->pluck('id');
                $deletedRows = ProjectUser::where('project_id', $val->project_id)
                    ->whereIn('user_id', $userIdsToRemove->toArray())
                    ->delete();
                }
            }
     
        }
        $client = ClientUpdate::where('uniq_id', $request->input('uniq_id'))->first();
        $client->update($request->all());

        return $this->jsonSuccess('Updated client successfully', $client);
    }

    public function postParent(WebappClientParentPostRequest $request, StoreLogo $logo)
    {
        $data = $request->all();
        $data['child_of_id'] = 0;
	    $data['facelistid']= $data['subdomain'];
	
        $client = ClientAdd::create($data);

	require_once 'HTTP/Request2.php';
	$facelistid=$data['facelistid'];
    
    $requestt = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/'.$facelistid);

    $url = $requestt->getUrl();

    $headers = array(
        // Request headers
        'Content-Type' => 'application/json',
        'Host'         => 'westus.api.cognitive.microsoft.com',
        'Ocp-Apim-Subscription-Key' => '013880a7eb99412cb9a53d20810e096b'
    );

    $requestt->setHeader($headers);

    $parameters = array(
        
    );

    $url->setQueryVariables($parameters);

    $requestt->setMethod(\HTTP_Request2::METHOD_PUT);

// Request body
    $requestt->setBody('{
        "name":"sample_list",
        "userData":"User-provided data attached to the face list"
    }');
 
    try
    {
        $response = $requestt->send();
        // echo $response->getBody();
        $ocean = "chal gaya";

    }
    catch (HttpException $ex)
    {
        // echo $ex;
    }

        if(!empty($request->input('image'))){
            $access  = new Access(Auth::user());
            $clients = new PermittedToAccess($request, $access->getAsType());
            
            $contents = $request->input('image');
            
            $logo->store($client->uniq_id,$contents);
        }

        
        // return $this->jsonSuccess('Logo updated successfully', null);
        return $this->jsonSuccess('Created client successfully', $client);
    }

    public function post(WebappClientPostRequest $request)
    {
        $parentClient   = Client::where('uniq_id', $request->input('parent_uniq_id'))->first();
        $data = $request->all();
        $data['child_of_id'] = $parentClient->id;
        $data['plan_test'] = $parentClient->plan_test;

        $client = Client::create($data);

        $facelistid = DB::table('clients')
            ->where('id', $client->id)
            ->select(['subdomain'])
            ->first();

        $update = DB::table('clients')
            ->where('id', $client->id)
            ->update(array('facelistid' => $facelistid->subdomain));



        require_once 'HTTP/Request2.php';
    $facelistid=$facelistid->subdomain;
    
    $requestt = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/'.$facelistid);

    $url = $requestt->getUrl();

    $headers = array(
        // Request headers
        'Content-Type' => 'application/json',
        'Host'         => 'westus.api.cognitive.microsoft.com',
        'Ocp-Apim-Subscription-Key' => '013880a7eb99412cb9a53d20810e096b'
    );

    $requestt->setHeader($headers);

    $parameters = array(
        
    );

    $url->setQueryVariables($parameters);

    $requestt->setMethod(\HTTP_Request2::METHOD_PUT);

// Request body
    $requestt->setBody('{
        "name":"sample_list",
        "userData":"User-provided data attached to the face list"
    }');
 
    try
    {
        $response = $requestt->send();
        // echo $response->getBody();
        $ocean = "chal gaya";

    }
    catch (HttpException $ex)
    {
        // echo $ex;
    }
        return $this->jsonSuccess('Created client successfully', $client);
    }

    //
    // Must be admin in routes/api.php
    //
    public function putLogo(Request $request, StoreLogo $logo)
    {
        $access  = new Access(Auth::user());
        $clients = new PermittedToAccess($request, $access->getAsType());
        $client  = $clients->getClient($request->input('uniq_id'));
        $contents = $request->input('image');
        //$clientid="";
        //$logo->store($client->uniq_id,$clientid,$contents);
        $logo->store($client->uniq_id,$contents);
        return $this->jsonSuccess('Logo updated successfully', null);
    }

    public function delete(Request $request, $uniq_id)
    { 
        $Access   = new Access(Auth::user());
        $authUser = $Access->getAsType();
        $clients  = new PermittedToAccess($request, $authUser);

        $result = $clients->remove($uniq_id);

        if (!$result) {
            return $this->jsonFailure("Unable to remove client");
        }

        return $this->jsonSuccess("Removed client", []);
    }
}
