<?php

namespace App\Http\Controllers;

use App\User;
use App\Project;
use App\ProjectUser;
use App\UserLog;
use App\UserBadgeData;
use App\UserStoreAvatar;
use Log;
use Storage;
use Illuminate\Http\Request;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests\PutUserRequest;
use App\Http\Requests;
use DB;

class UserController extends ApiController
{
    public function profile()
    {
        $profile = User::where('id', Auth::user()->id)->getClean();
        
        $profile->avatar = $profile->avatar;
        $subdomain = DB::table('clients')
            ->where('id', $profile->client_id)
            ->select(['subdomain'])
            ->first();

            if($profile->client->child_of_id != 0){
                $createdAT = DB::table('clients')
                ->where('id', $profile->client->child_of_id)
                ->select(['created_at'])
                ->first();
                $createdAT->created_dateParent = $createdAT->created_at;
                unset($createdAT->created_at);
                
            }
                
            if(isset($createdAT)){
                $a = json_decode(json_encode($profile), true);
                $b = json_decode(json_encode($subdomain), true);
                $c = json_decode(json_encode($createdAT), true);
                // $d = json_decode(json_encode($data), true);
                $data = array_merge($a,$b,$c);
            }
            else{
                $a = json_decode(json_encode($profile), true);
                $b = json_decode(json_encode($subdomain), true);
                $data = array_merge($a,$b);
            }
        
            // $subdomain->subdomain

            // $fsgt = array_merge($subdomain,$profile);
          //$a = (array) $profile;
           // $b = (array) $subdomain;

            // $new_pro['client']['subdomain'] = 'fgskojfsfkjsahjsa';
        return $this->jsonSuccess("Successfully retrieved your profile", $data);
    }

    public function logs()
    {
        $logs = UserLog::where('user_id', Auth::user()->id)
            ->orderBy('dateTime', 'DESC')
            ->paginate(10);
        $logs->load('project');

        $logs->map(function ($item, $key) {
            unset($item->id);
            unset($item->user_id);
            unset($item->project_id);

            return $item;
        });

        return $this->respondWithJsonPagination($logs);
    }

    public function postLog(Requests\UserLogsPostRequest $request)
    {
        $project = Project::where('uniq_id', $request->input('uniq_id'))->first();

        if (! $project) {
            return $this->jsonFailure('Project not found');
        }

        $log = new UserLog;
        $log->user_id = Auth::user()->id;
        $log->project_id = $project->id;
        $log->type = 'general';
        $log->note = $request->input('note');
        $log->save();
        // $request->file('files')

        return $this->jsonSuccess("Successfully wrote log", null);
    }

    public function putProfile(PutUserRequest $request)
    {
        $preFields  = $request->only('first_name', 'last_name', 'email', 'username', 'jdoc', 'mobileNumber');
        $fields = $preFields;
        $fields['jdoc']  = json_encode($fields['jdoc']);
        User::where('id', '=', Auth::user()->id)->update($fields);

        return $this->jsonSuccess('Profile updated successfully', $preFields);
    }

    public function putAvatar(Request $request, UserStoreAvatar $avatar)
    {
        $user = Auth::user();
        $contents = json_decode($request->getContent());

        $avatar->store($user, $contents);
        return $this->jsonSuccess('Avatar updated successfully', null);
    }

    public function getAvatar($uniq_id = null)
    {
        if (! $uniq_id) {
            $uniq_id = Auth::user()->uniq_id;
        }

        $user    = Auth::user();
        $storage = Storage::disk('avatars');

        foreach (['png', 'jpg'] as $ext) {
            $fileName = $uniq_id . '.' . $ext;
            if ($storage->exists($fileName)) {
                return Image::make($storage->get($fileName))->response();
            }
        }

        //
        // looped, didn't find
        //
        if (! Storage::disk('local')->exists('placeholder-avatar.png')) {
            return $this->jsonFailure("Neither user or default avatar found");
        }

        return Image::make(Storage::disk('local')->get('placeholder-avatar.png'))->response();
    }

    public function qr($user_uniq_id = null, $project_uniq_id = null)
    {
        $json = new \stdClass;
        $json->user_uniq_id = $user_uniq_id;
        $json->project_uniq_id = $project_uniq_id;

        $renderer = new \BaconQrCode\Renderer\Image\Png();
        $renderer->setHeight(256);
        $renderer->setWidth(256);
        $writer = new \BaconQrCode\Writer($renderer);

        return response($writer->writeString(json_encode($json)))
             ->header('Content-Type', 'image/png');
    }


    public function badge($user_uniq_id = null, $project_uniq_id = null)
    {
        $user        = User::where('uniq_id', $user_uniq_id)->first();
        $project     = Project::where('uniq_id', $project_uniq_id)->first();

        $badgeData = new UserBadgeData($user, $project);

        return $this->jsonSuccess("Badge found", $badgeData->get());
    }





    protected function mergeProfileChanges($profile, $fields)
    {
        foreach ($fields as $field => $value) {
            if ($field == 'jdoc') {
                $jdoc = $profile['jdoc'];
                $jdocFields = (array)$value;

                foreach ($jdocFields as $jField => $jValue) {
                    $jdoc[$jField] = $jValue;
                }

                $profile['jdoc'] = $jdoc;
            } else {
                $profile[$field] = $value;
            }
        }

        return $profile;
    }
}
