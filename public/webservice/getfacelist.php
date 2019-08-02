<?php
// This sample uses the Apache HTTP client from HTTP Components (http://hc.apache.org/httpcomponents-client-ga/)
require_once 'HTTP/Request2.php';

$request = new Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/facelists/');
$url = $request->getUrl();

$headers = array(
    // Request headers
      'Ocp-Apim-Subscription-Key' => 'd8fe58ed465e4c42b2bb5c69d6a3b578'
);

$request->setHeader($headers);

$parameters = array(
    
);

$url->setQueryVariables($parameters);

$request->setMethod(HTTP_Request2::METHOD_GET);

// Request body
$request->setBody('{
    "name":"sample_list",
    "userData":"User-provided data attached to the face list"
}');

try
{
    $response = $request->send();
    echo '<pre>'; print_r($response->getBody());
    
}
catch (HttpException $ex)
{
    echo $ex;
}

?>