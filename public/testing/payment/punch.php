<?php
$conn_string = "host=localhost port=5432 dbname=punchcard user=postgres password=p^5$3@1";
$dbconn = pg_connect($conn_string);

//$query = pg_query($dbconn, "SELECT c.name as c_name,c.status as c_status, u.role as u_role, u.id as uid, u.first_name as u_firstname,u.last_name as u_lastname, u.email as u_email FROM  clients as c LEFT JOIN users as u  ON c.id = u.client_id WHERE u.role='user' ORDER BY u.id DESC");
//$query = pg_query($dbconn, "SELECT * FROM  clients as c LEFT JOIN users as u  ON c.id = u.client_id  ");

 $query = pg_query($dbconn, "SELECT c.name as c_name,c.status as c_status, u.role as u_role, u.id as uid, u.first_name as u_firstname,u.last_name as u_lastname, u.email as u_email FROM  clients as c LEFT JOIN users as u  ON  u.client_id = c.id WHERE c.id='88' ORDER BY u.id DESC");
//$query = pg_query($dbconn, "SELECT * FROM users WHERE client_id='88'");

//$data = pg_fetch_row($query);
//var_dump($data);
while($row = pg_fetch_row($query)) {
      echo "Client Name = ". $row[0] . "\n";
      echo "Client Status = ". $row[1] ."\n";
      echo "User Role = ". $row[2] ."\n";
      echo "User ID =  ".$row[3] ."\n";
      echo "User FName =  ".$row[4] ."\n\n";
   }
?>