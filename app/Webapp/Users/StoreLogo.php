<?php namespace App\Webapp\Users;

use App\Exceptions\BadInputException;
use Storage;
use App\Store\Store;
use App\Webapp\Users\PermittedToAccess;
use Auth;

/**
 * Store the users's avatar
 *
 * @author Hans Anderson <me@hansanderson.com>
 */
class StoreLogo extends Store
{
    protected $disk = 'avatars';

    public function storeAvatar($request)
    {
        $access  = new Access(Auth::user());
        $users = new PermittedToAccess($request, $access->getAsType());
        $user  = $users->getUser($request->input('uniq_id'));
        $contents = $request->input('image');
	return $this->store($user->uniq_id, $contents);
        //return $this->store($user->uniq_id, $user->client_id,  $contents);
    }
}
