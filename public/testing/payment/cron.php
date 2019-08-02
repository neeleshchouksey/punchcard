<?php
$conn_string = "host=localhost port=5432 dbname=punchcard user=postgres password=p^5$3@1";
$dbconn = pg_connect($conn_string);


 $query = pg_query($dbconn, "SELECT * FROM  clients  WHERE date(created_at) + '24 days'::interval = CURRENT_DATE ORDER BY id DESC");
 $query2 = pg_query($dbconn, "SELECT * FROM  clients  WHERE date(created_at) + '24 days'::interval > CURRENT_DATE ORDER BY id DESC");
 //$query = pg_query($dbconn, "SELECT date(created_at) + '30 days'::interval  FROM  clients  ORDER BY id DESC LIMIT 10");
if($rows = pg_num_rows($query)>0){  // if trial pack completed today
while($row = pg_fetch_row($query)) {
      echo "Client Name = ". $row[0] . "\n";
     
   }
}elseif($rows2 = pg_num_rows($query2)>0){  // if trial pack already completed

	if(){  // checking that has credit-card details saved ?

	}
}
?>