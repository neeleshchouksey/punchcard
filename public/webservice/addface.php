<?php
// This sample uses the Apache HTTP client from HTTP Components (http://hc.apache.org/httpcomponents-client-ga/)
require_once 'HTTP/Request2.php';

$request = new Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/sourav/persistedFaces');
$url = $request->getUrl();

$headers = array(
    // Request headers
    'Content-Type' => 'application/json',
    'Ocp-Apim-Subscription-Key' => 'd8fe58ed465e4c42b2bb5c69d6a3b578',
);

$request->setHeader($headers);

$parameters = array(
    // Request parameters
    // 'userData' => '{string}',
    // 'targetFace' => '{string}',
);

$url->setQueryVariables($parameters);

$request->setMethod(HTTP_Request2::METHOD_POST);

// Request body
$request->setBody('{
    "url": "http://ihos.punchcardllc.com/webservice/2.jpg"
}');

try
{
    $response = $request->send();
    echo $response->getBody();
}
catch (HttpException $ex)
{
    echo $ex;
}

?>