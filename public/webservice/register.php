<?php 

$conn_string = "host=localhost port=5432 dbname=punchcard user=postgres password=p^5$3@1";
$dbconn4 = pg_connect($conn_string);

$faceid=$_GET['faceid'];
// $faceid=33;
$nosetomouthdistance=$_GET['nosetomouthdistance'];
// $nosetomouthdistance=3;
$eyedistance=$_GET['eyedistance'];
// $eyedistance=4;
$ishappy=$_GET['ishappy'];
// $ishappy=5;
$facerotation=$_GET['facerotation'];

// print_r($_GET);die;


$query = "INSERT INTO facedata (face_id,nosetomouthdistance,eyedistance,ishappy,facerotation) VALUES ('$faceid','$nosetomouthdistance','$eyedistance','$ishappy','$facerotation')";

$result = pg_query($dbconn4, $query);

if($result){
 $json = array("status" => 1, "msg" => "added successfully");
 }else{
 $json = array("status" => 0, "msg" => "Error adding user!");
 }

 echo json_encode($json);

?>