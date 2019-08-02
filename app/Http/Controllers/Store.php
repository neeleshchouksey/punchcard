<?php namespace App\Store;

use Storage;
use Illuminate\Support\Facades\DB;

class Store
{
    protected $disk;

    // public function store($uniq_id, $client_id, $contents)
    public function store($uniq_id, $contents)
    {
        $storage = Storage::disk($this->disk);
        $image   = base64_decode($contents);
        $extension     = $this->getExtension($image);
        $this->clean($storage, $uniq_id);

        $return_thing = $storage->put("{$uniq_id}.{$extension}", $image);

        

        return $return_thing;
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

        if ($this->isExtensionJpg($mimeType)) {
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

    protected function clean($storage, $uniq_id)
    {
        foreach (['png', 'jpg'] as $checkExt) {
            $fileName = $uniq_id . '.' . $checkExt;
            $this->removelogoIfExists($storage, $fileName);
        }
    }

    protected function removelogoIfExists($storage, $fileName)
    {
        if ($storage->exists($fileName)) {
            $storage->delete($fileName);
        }
    }
}
