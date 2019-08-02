<?php 
// echo 'ocean';

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
// $facerotation=6;


$query = "SELECT * FROM facedata WHERE nosetomouthdistance = '$nosetomouthdistance' AND face_id = '$faceid' AND eyedistance = '$eyedistance' AND ishappy = '$ishappy' AND facerotation = '$facerotation' ";

$result = pg_query($dbconn4, $query);

$row = pg_fetch_assoc($result);
// print_r($row);die;
if(!empty($row)){
 $json = array("status" => 1, "msg" => "Login successfully","face_id"=>$row['face_id']);
 }else{
 $json = array("status" => 0, "msg" => "Login fails");
 }

 echo json_encode($json);
// $result = pg_query($dbconn4, "select * from users");
// echo '<pre>';print_r(pg_fetch_all($result));
?>