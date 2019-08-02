<?php namespace App\Http\Controllers;

use Auth;
use App\UserAdmin;
use App\Timesheets;
use App\UserRole;
use App\User;
use App\Webapp\Users\StoreLogo;
use App\Client;
use App\Webapp\Users;
use App\Http\Requests;
use App\Webapp\Users\Access;
use Illuminate\Http\Request;
use App\Webapp\Users\PermittedToAccess;
use App\Webapp\Users\UserWebapp;
use Illuminate\Support\Facades\DB;
use App\CheckStatsData;
use App\CheckStats;



class UserWebappController extends ApiController
{
    public function profile($uniq_id = null)
    {
        if (! $uniq_id) {
            $uniq_id = Auth::user()->uniq_id;
        }

        $profile = User::with('client')->where('uniq_id', $uniq_id)->first();
        $profile->avatar = $profile->avatar;
        return $this->jsonSuccess("Showing user profile", $profile);
    }

    public function postUser(Requests\PostUserWebappRequest $request,  StoreLogo $logo)
    {
        $data = $request->all(); // json is an object, with create doesn't like

        $client_uniq_id = $request->input('client_uniq_id');
        $client = Client::where('uniq_id', $client_uniq_id)->first();

        if (!$client) {
            return $this->jsonFailure('Client not found');
        }

        $data['client_id'] = $client->id;
        $result = Users\Add::create($data);


        if(!empty($request->image)){

            $access  = new Access(Auth::user());
            $users = new PermittedToAccess($request, $access->getAsType());
            $user  = $users->getUser($result->uniq_id);
            $contents = $request->input('image');
        

        if ($logo->store($user->uniq_id, $contents)) {

            $uniq_id=$result->uniq_id;

            $access  = new Access(Auth::user());
            $users = new PermittedToAccess($request, $access->getAsType());
            $user  = $users->getUser($uniq_id);

            

            //added by Ocean to run microsoft api to store face in facelist...
            $client_user =  DB::select(DB::raw('select facelistid from clients where id = '.$user->client_id));

            $facelistid = "";

            if( !empty($client_user) ) {
                foreach ($client_user as $key => $value) {
                    $facelistid = $value->facelistid;
                }
            }

            if( !empty($facelistid) ) {

                $image_url = "http://".$facelistid.".punchcardllc.com/api/v1.0/user/avatar/".$uniq_id;

                require_once 'HTTP/Request2.php';

              $request = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/'.$facelistid.'/persistedFaces');


   //$request = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/test123/persistedFaces');
                $url = $request->getUrl();

                $headers = array(
                    // Request headers
                    'Content-Type' => 'application/json',
                    'Ocp-Apim-Subscription-Key' => '013880a7eb99412cb9a53d20810e096b'
                );

                $request->setHeader($headers);

                $parameters = array(
                    // Request parameters
                    // 'userData' => '{string}',
                    // 'targetFace' => '{string}',
                );

                $url->setQueryVariables($parameters);

                $request->setMethod(\HTTP_Request2::METHOD_POST);

                // Request body\
                
                $request->setBody('{
                    "url": "'.$image_url.'"
                }');

    try
    {
       $response = $request->send();
    $a=  $response->getBody();
    $b=json_decode($a);
    if(array_key_exists('persistedFaceId', $b)){
        $persistedFaceId = $b->persistedFaceId;
    $update = DB::table('users')
            ->where('id', $user['id'])
            ->limit(1)
            ->Update(array('persistancefaceid'=> $persistedFaceId));
 
       }
    }
    catch (HttpException $ex)
    {
        // echo $ex;
    }
}
            //End of microsoft api code...
            
    }else{
            if($result->client->child_of_id == 0){
            return $this->jsonSuccess('User added to client company but error when storing avatar', $result);
        }

        return $this->jsonSuccess('User added to child company but error when storing avatar', $result);
    }
           
        }

        if($result->client->child_of_id == 0){
            return $this->jsonSuccess('User added to '.$result->client->name.' company successfully', $result);
        }

        return $this->jsonSuccess('User added to'.$result->client->name.' company successfully', $result);
    }

    public function putUser(Requests\PutUserWebappRequest $request,  StoreLogo $logo)
    {
        $user = UserWebapp::where('uniq_id', '=', $request->input('uniq_id'))->first();
        $user->update($request->all());

        if(!empty($request->image)){

            $access  = new Access(Auth::user());
            $users = new PermittedToAccess($request, $access->getAsType());
            $user  = $users->getUser($request->input('uniq_id'));
            $contents = $request->input('image');
        

        if ($logo->store($user->uniq_id, $contents)) {

            $uniq_id=$request->input('uniq_id');

            $access  = new Access(Auth::user());
            $users = new PermittedToAccess($request, $access->getAsType());
            $user  = $users->getUser($uniq_id);

            

            //added by Ocean to run microsoft api to store face in facelist...
            $client_user =  DB::select(DB::raw('select facelistid from clients where id = '.$user->client_id));

            $facelistid = "";

            if( !empty($client_user) ) {
                foreach ($client_user as $key => $value) {
                    $facelistid = $value->facelistid;
                }
            }

            if( !empty($facelistid) ) {

                $image_url = "http://".$facelistid.".punchcardllc.com/api/v1.0/user/avatar/".$uniq_id;

                require_once 'HTTP/Request2.php';

              $request = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/'.$facelistid.'/persistedFaces');


   //$request = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/test123/persistedFaces');
                $url = $request->getUrl();

                $headers = array(
                    // Request headers
                    'Content-Type' => 'application/json',
                    'Ocp-Apim-Subscription-Key' => '013880a7eb99412cb9a53d20810e096b'
                );

                $request->setHeader($headers);

                $parameters = array(
                    // Request parameters
                    // 'userData' => '{string}',
                    // 'targetFace' => '{string}',
                );

                $url->setQueryVariables($parameters);

                $request->setMethod(\HTTP_Request2::METHOD_POST);

                // Request body\
                
                $request->setBody('{
                    "url": "'.$image_url.'"
                }');

    try
    {
       $response = $request->send();
    $a=  $response->getBody();
    $b=json_decode($a);
    if(array_key_exists('persistedFaceId', $b)){
        $persistedFaceId = $b->persistedFaceId;
    $update = DB::table('users')
            ->where('id', $user['id'])
            ->limit(1)
            ->Update(array('persistancefaceid'=> $persistedFaceId));
 
       }
    }
    catch (HttpException $ex)
    {
        // echo $ex;
    }
}
            //End of microsoft api code...
            
    }else{
            
            return $this->jsonSuccess('User updated successfully but error when storing avatar', $result);
        

        
    }
           
        }

        return $this->jsonSuccess('User updated successfully', $user);
    }

    public function putAvatar(Request $request, StoreLogo $logo)
    {
        if ($logo->storeAvatar($request)) {

            $access  = new Access(Auth::user());
            $users = new PermittedToAccess($request, $access->getAsType());
            $user  = $users->getUser($request->input('uniq_id'));

            $uniq_id=$request->input('uniq_id');

            //added by Ocean to run microsoft api to store face in facelist...
            $client_user =  DB::select(DB::raw('select facelistid from clients where id = '.$user->client_id));

            $facelistid = "";

            if( !empty($client_user) ) {
                foreach ($client_user as $key => $value) {
                    $facelistid = $value->facelistid;
                }
            }

            if( !empty($facelistid) ) {

                $image_url = "http://".$facelistid.".punchcardllc.com/api/v1.0/user/avatar/".$request->input('uniq_id');

                require_once 'HTTP/Request2.php';

              $request = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/'.$facelistid.'/persistedFaces');


   //$request = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/test123/persistedFaces');
                $url = $request->getUrl();

                $headers = array(
                    // Request headers
                    'Content-Type' => 'application/json',
                    'Ocp-Apim-Subscription-Key' => '013880a7eb99412cb9a53d20810e096b'
                );

                $request->setHeader($headers);

                $parameters = array(
                    // Request parameters
                    // 'userData' => '{string}',
                    // 'targetFace' => '{string}',
                );

                $url->setQueryVariables($parameters);

                $request->setMethod(\HTTP_Request2::METHOD_POST);

                // Request body\
                
                $request->setBody('{
                    "url": "'.$image_url.'"
                }');

    try
    {
       $response = $request->send();
    $a=  $response->getBody();
    $b=json_decode($a);
    if(array_key_exists('persistedFaceId', $b)){
        $persistedFaceId = $b->persistedFaceId;
    $update = DB::table('users')
            ->where('id', $user['id'])
            ->limit(1)
            ->Update(array('persistancefaceid'=> $persistedFaceId));
 
       }else{
        return $this->jsonSuccess('Avatar updated successfully');
    }
   
    
//DB::update(DB::raw("UPDATE users SET persistanceFaceId='$persistedFaceId' WHERE uniq_id='$uniq_id'"));

//DB::update(DB::raw("UPDATE users SET persistanceFaceId='1f32eeeb-efa1-4450-9714-5b434f85fae5' WHERE uniq_id='2ca285dc-df6d-4ba5-ac61-ce75baa50ec8'"));

// $a="UPDATE `users` SET `persistanceFaceId`='$persistedFaceId' WHERE `uniq_id`='$uniq_id'";
    }
    catch (HttpException $ex)
    {
        echo $ex;
    }
}
            //End of microsoft api code...
            return $this->jsonSuccess('Avatar updated successfully');
        }

        return $this->jsonFailure('Error when storing avatar', null);
    }

    public function view(Request $request, $uniq_id)
    {
        $user = UserWebapp::getUser($request, $uniq_id);

        if ($user === null) {
            return $this->jsonDenied('No access or user not found');
        }
    
        $clientData = $user->toArray();

            $newProData = array();
            $getUser =  Auth::user();

        foreach($clientData['projects'] as $proData){
           
            $checkStatsData = new CheckStatsData;
            $oceanUser = User::find($getUser->id);
            $checkStatsData->setUser($oceanUser);
            $data = $checkStatsData->getProjectStatsData($proData['id']);

            $checkStats = new CheckStats($data);
            $stats = $checkStats->getStats();
            $proData['oceanStats'] = $stats; 
            $newProData[] = $proData;           

        }

        $clientData['projects'] = $newProData;
        return $this->jsonSuccess('Showing user', $clientData);
    }

    public function saveTimesheet(Request $request, $uniq_id)
    {
        if ($updatedTimesheet = Timesheets::saveCheckDateTimeChange($request->all(), $uniq_id)) {
            return $this->jsonSuccess('Updated', $updatedTimesheet);
        }

        return $this->jsonFailure('Unable to save the change.');
    }


    public function timesheets(Request $request, $uniq_id)
    {
        $user = UserWebapp::getUser($request, $uniq_id);

        if ($user === null) {
            return $this->jsonDenied('No access or user not found');
        }

        $toViewUserTimesheets = Timesheets::getSheets($user, 999999);
        $toViewUserTimesheets->load('project');
        return $this->respondWithJsonPagination($toViewUserTimesheets);
    }

    public function deleteUser($uniq_id)
    {
        $user = User::where('uniq_id', $uniq_id)->first();

        if ($user === null) {
            return $this->jsonFailure('User not found', []);
        }

        $user->delete();

        return $this->jsonSuccess('User successfully deleted', []);
    }
}
