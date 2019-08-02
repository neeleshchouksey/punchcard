<?php

$card_number=$_REQUEST['card_number'];
$card_type=$_REQUEST['card_type'];
$expire_month=$_REQUEST['expire_month'];
$expire_year='20'.$_REQUEST['expire_year'];
$cvv2=$_REQUEST['cvv2'];
$first_name=$_REQUEST['first_name'];
$last_name=$_REQUEST['last_name'];
//$billing_address=$_POST['billing_address'];
$line1=$_REQUEST['line1'];
$city=$_REQUEST['city'];
$country_code=$_REQUEST['country_code'];
$postal_code=$_REQUEST['postal_code'];
$state=$_REQUEST['state'];
$phone=$_REQUEST['phone'];
$external_customer_id=$first_name.'_'.$last_name.$phone;

$conn_string = "host=localhost port=5432 dbname=punchcard user=postgres password=p^5$3@1";
$dbconn = pg_connect($conn_string);

$query = pg_query($dbconn, "SELECT secret_key FROM access_token_test ORDER BY id DESC 
LIMIT 1");

$data = pg_fetch_assoc($query);

$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, "https://api.sandbox.paypal.com/v1/vault/credit-cards/");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, "{\n  \"number\":\"$card_number\",\n  \"type\":\"$card_type\",\n  \"expire_month\":$expire_month,\n  \"expire_year\":$expire_year,\n  \"cvv2\":\"$cvv2\",\n  \"first_name\":\"$first_name\",\n  \"last_name\":\"$last_name\",\n  \"billing_address\":{\n    \"line1\":\"$line1\",\n    \"city\":\"$city\",\n    \"country_code\":\"$country_code\",\n    \"postal_code\":\"$postal_code\",\n    \"state\":\"$state\",\n    \"phone\":\"$phone\"\n  },\n  \"external_customer_id\":\"$external_customer_id\"\n}");
curl_setopt($ch, CURLOPT_POST, 1);

$headers = array();
$headers[] = "Content-Type: application/json";
$headers[] = "Authorization: Bearer ".$data['secret_key'];
// echo "Authorization: Bearer ".$data['secret_key'];
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

$result = curl_exec($ch);
if (curl_errno($ch)) {
    echo 'Error:' . curl_error($ch);
}
curl_close ($ch);
//print_r($result);die;
$result=json_decode($result,true);
//print_r($result);die;
if(isset($result['state']) && $result['state']!=''){
$query2 = pg_query($dbconn, "INSERT INTO cc_users(first_name,last_name,phone,address,city,state,country,postal_code,cc_id,created_at,cc_state,cc_external_customer_id,cc_type,cc_number,cc_expire_month,cc_expire_year,cc_valid_until,cc_create_time,cc_update_time,cc_links) VALUES('$first_name','$last_name','$phone','$line1','$city','$state','$country_code','$postal_code','".$result["id"]."','now()','".$result["state"]."','$external_customer_id','".$result["type"]."','".$result["number"]."','".$result["expire_month"]."','".$result["expire_year"]."','".$result["valid_until"]."','".$result["create_time"]."','".$result["update_time"]."','".json_encode($result["links"])."')");	
echo $result['state'];
header("location:checkout-form.php?msg=suc&cid=".$external_customer_id);
}
else{
$err= json_encode($result['details'],true);
echo $err;
header("location:checkout-form.php?msg=err");
}

?>