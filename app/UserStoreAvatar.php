<?php namespace App;

use App\Exceptions\BadInputException;
use Storage;

/**
 * Store the user's uploaded avatar
 *
 * @author Hans Anderson <me@hansanderson.com>
 */
class UserStoreAvatar
{
    /**
     * Store the user's uploaded avatar
     * @param $user array
     * @param $contents object
     * @returns bool
     */
    public function store($user, $contents)
    {
        $storage = Storage::disk('avatars');
        $image   = base64_decode($contents->image);
        $extension     = $this->getExtension($image);
        $this->cleanAvatars($storage, $user);
        return $storage->put("{$user->uniq_id}.{$extension}", $image);
    }

    /**
     * Avatar can be either jpg or png, so let's make sure they are all gone
     *
     * @param $storage object
     * @param $user array
     */
    protected function cleanAvatars($storage, $user)
    {
        foreach (['png', 'jpg'] as $checkExt) {
            $fileName = $user->uniq_id . '.' . $checkExt;
            $this->removeAvatarIfExists($storage, $fileName);
        }
    }

    /**
     * Remove the avatar file
     *
     * @param $storage object
     * @param $fileName string
     */
    protected function removeAvatarIfExists($storage, $fileName)
    {
        if ($storage->exists($fileName)) {
            $storage->delete($fileName);
        }
    }

    /**
     * Pass in the image in data and determine the image type, then return the extension
     *
     * @param $image blob
     * @returns string
     * @throws BadInputException
     *
     */
    protected function getExtension($image)
    {
        $mimeType = $this->getMimeTypeFromImage($image);

        if ($mimeType == 'image/png') {
            return 'png';
        }

        if ($this->isExtensionJpg($mimeType))
        {
            return 'jpg';
        }

        throw new BadInputException('Image is not supported type: ' . $mimeType);
    }

    /**
     * Determine if the uploaded image is a jpg image, based on the mimetype
     *
     * @param $mimeType string
     * @returns boolean
     */
    protected function isExtensionJpg($mimeType)
    {
        if ($mimeType == 'image/jpg' or $mimeType == 'image/jpeg') {
            return true;
        } else {
            return false;
        }
    }

    /**
     * Get mime from image information detected by the built-in php function
     *
     * @param $image blog
     */
    protected function getMimeTypeFromImage($image)
    {
        $info  = getimagesizefromstring($image);
        return $info['mime'];
    }
}
