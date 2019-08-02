<?php
   $host        = "host=punchcarddev.cohfevnhmtmi.us-east-1.rds.amazonaws.com";
   $port        = "port=5432";
   $dbname      = "dbname=punchcard";
   $credentials = "user=punchcarddbadmin password=PunchCard12345678";

   $db = pg_connect( "$host $port $dbname $credentials"  );
   if(!$db){
      echo "Error : Unable to open database\n";
   } else {
      echo "Opened database successfully\n";
   }
?>
