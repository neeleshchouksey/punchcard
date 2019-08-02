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

class TestController extends ApiController
{

    public function test()
    {
     echo $password = bcrypt('secret');
    }

}
