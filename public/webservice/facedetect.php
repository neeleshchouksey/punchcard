<?php
// This sample uses the Apache HTTP client from HTTP Components (http://hc.apache.org/httpcomponents-client-ga/)

$conn_string = "host=punchcarddev.cohfevnhmtmi.us-east-1.rds.amazonaws.com port=5432 dbname=punchcard user=punchcarddbadmin password=PunchCard12345678";


    // $connection = pg_connect ("host=punchcarddev.cohfevnhmtmi.us-east-1.rds.amazonaws.com port=5432 dbname=punchcard user=punchcarddbadmin password=PunchCard12345678");
    // if($connection) {
    //    echo 'connected';die;
    // } else {
    //     echo 'there has been an error connecting';die;
    // } 

$dbconn4 = pg_connect($conn_string);
function gen_uuid() {
    return sprintf( '%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
        // 32 bits for "time_low"
        mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ),

        // 16 bits for "time_mid"
        mt_rand( 0, 0xffff ),

        // 16 bits for "time_hi_and_version",
        // four most significant bits holds version number 4
        mt_rand( 0, 0x0fff ) | 0x4000,

        // 16 bits, 8 bits for "clk_seq_hi_res",
        // 8 bits for "clk_seq_low",
        // two most significant bits holds zero and one for variant DCE1.1
        mt_rand( 0, 0x3fff ) | 0x8000,

        // 48 bits for "node"
        mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff )
    );
}
if( !empty($_REQUEST['sub_domain']) ) {

	require_once 'HTTP/Request2.php';


	

	ini_set('upload_tmp_dir', '/tmp');


	if(isset($_FILES['selfie'])){
		$file_size = $_FILES['selfie']['size'];
		$file_type = $_FILES['selfie']['type'];
		$temp_name = $_FILES['selfie']['tmp_name']; 
		$file_name = time().$_FILES['selfie']['name'];
		
	 	$location = "selfie/";

	 	if(move_uploaded_file($temp_name, $location.$file_name)){

	 	}else{
	 		echo "error in uploading ".$file_name;
	 	}
	 }else{
	 	$file_name = '';
	 }


	if( $file_name != "" ) { 

		$request = new Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/detect');
		$url = $request->getUrl();

		$headers = array(
		    // Request headers
		    'Content-Type' => 'application/json',
		    'Host' => 'westus.api.cognitive.microsoft.com',
		    'Ocp-Apim-Subscription-Key' => '013880a7eb99412cb9a53d20810e096b',
		);

		$request->setHeader($headers);

		$parameters = array(
		'returnFaceId' => 'true',
		    'returnFaceLandmarks' => 'false',
		);

		$url->setQueryVariables($parameters);

		$request->setMethod(HTTP_Request2::METHOD_POST);

		// Request body
		$request->setBody('{
		"url":"http://punchcardllc.com/webservice/'.$location.$file_name.'"
		       }');

		try
		{
		    $response = $request->send();
		    $res =  json_decode($response->getBody());
            //print_r($res);
            
            if( count($res) ==  0) {
            	$arrayNameface = array('message' => 'Image must contains face', 'success'=>'false');
			   echo json_encode($arrayNameface);die;
            	
            }

            $faceId = "";

		   foreach($res as $value){
				$faceId = $value->faceId;
		   }

		   if( !empty($faceId) ) {

		   		$facelistid = $_REQUEST['sub_domain'];

		   		$request = new Http_Request2('https://westus.api.cognitive.microsoft.com/face/v1.0/findsimilars');
				$url = $request->getUrl();

				$headers = array(
				    // Request headers
				    'Content-Type' => 'application/json',
				    'Host' => 'westus.api.cognitive.microsoft.com',
				    'Ocp-Apim-Subscription-Key' => '013880a7eb99412cb9a53d20810e096b',
				);

				$request->setHeader($headers);

				$parameters = array(
				    // Request parameters
				);

				$url->setQueryVariables($parameters);

				$request->setMethod(HTTP_Request2::METHOD_POST);

				// Request body
				$request->setBody('{

				    "faceListId":"'.$facelistid.'",
				    "faceId":"'.$faceId.'",
					"maxNumOfCandidatesReturned":"1",
					"mode":"matchPerson"
				}');

				try
				{
				    $response = $request->send();

				    $final_match_res =  json_decode($response->getBody());

				       
				    $confidence = 0;
				    
				    foreach($final_match_res as $f_res) {
				    	
				    	if( !empty($f_res->confidence) )
				    	 {
				    		$confidence = $f_res->confidence;
				    		$persistancefaceid = $f_res->persistedFaceId;
				    		
						$result = pg_query($dbconn4, "SELECT users.uniq_id FROM users WHERE users.persistancefaceid ='".$persistancefaceid."'");
						$row = pg_num_rows($result);
						$data = pg_fetch_assoc($result);
						if($row == 0){
							$arrayName = array('message' => 'Match not found', 'success'=>'false');
			   				echo json_encode($arrayName);die;
						}else{
							echo json_encode($data);
						}
						
						die;
				    	}
				    	
				    	

				    }
				    $arrayName = array('message' => 'Match not found', 'success'=>'false');
			   echo json_encode($arrayName);die;


					  
			
			   		
					
					
				    //echo '$confidence '.$confidence;
				}
				catch (HttpException $ex)
				{
				    echo $ex;
				}
		   }

		   //echo $faceId;
		}
		catch (HttpException $ex)
		{
		    echo $ex;
		}
	}
}

?>