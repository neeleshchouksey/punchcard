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

        //added by Ocean to run microsoft api to store face in facelist...
        // $client_user =  DB::select(DB::raw('select facelistid from clients where id = '.$client_id));

        // $facelistid = "";

        // if( !empty($client_user) ) {
        //     foreach ($client_user as $key => $value) {
        //         $facelistid = $value->facelistid;
        //     }
        // }

        // if( !empty($facelistid) ) {
        //     require_once 'HTTP/Request2.php';

        //     $request = new \Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/'.$facelistid.'/persistedFaces');
        //     $url = $request->getUrl();

        //     $headers = array(
        //         // Request headers
        //         'Content-Type' => 'application/json',
        //         'Ocp-Apim-Subscription-Key' => 'd8fe58ed465e4c42b2bb5c69d6a3b578',
        //     );

        //     $request->setHeader($headers);

        //     $parameters = array(
                
        //     );

        //     $url->setQueryVariables($parameters);

        //     $request->setMethod(\HTTP_Request2::METHOD_POST);

        //     // Request body
        //     $request->setBody('{
        //         "url": "http://ocean3.punchcardllc.com/api/v1.0/user/avatar/"'.$uniq_id.'
        //     }');

        //     $response = $request->send();
        // }
        //End of microsoft api code...

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
