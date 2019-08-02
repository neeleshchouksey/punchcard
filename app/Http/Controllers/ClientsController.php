<?php

namespace App\Http\Controllers;

use Log;
use Storage;
use Illuminate\Http\Request;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests;

class ClientsController extends ApiController
{
    public function getLogo($uniq_id = null)
    {
        if (! $uniq_id && Auth::user()) {
            $uniq_id = Auth::user()->client->uniq_id;
        }

        $user    = Auth::user();
        $storage = Storage::disk('logos');

        foreach (['png', 'jpg'] as $ext) {
            $fileName = $uniq_id . '.' . $ext;
            if ($storage->exists($fileName)) {
                return Image::make($storage->get($fileName))->response();
            }
        }

        //
        // looped, didn't find
        //
        if (! Storage::disk('local')->exists('placeholder-logo.png')) {
            return $this->jsonFailure("Neither user or default logo found");
        }

        return Image::make(Storage::disk('local')->get('placeholder-logo.png'))->response();
    }
}
