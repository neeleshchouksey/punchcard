<!DOCTYPE html>
<html>
<head>
	<title>Punchcard</title>
</head>
<body style="
    margin: 0px;
    line-height: normal;
    background: #f7f4f4;
    padding: 0px;
    font-family: sans-serif;
    box-sizing: border-box;
">
<table style="width: 100%;max-width: 500px;
    margin: 30px auto;
    background: #fff;
    border: solid 1px #ddd;
">
	<tbody><tr>
		<!-- logo -->
		<td style="
    text-align: center;
    padding: 9px;
">
		<img src="{{ url ('images/logo1.png')}}">	

		</td>
	</tr>



	<tr>
		<td style="
    padding: 10px;
">
			<h3 style="
    font-size: 18px;
">Hello {{ $clientAdminFirstName }}!</h3>
			<p style="
    color: #333232;
    font-size: 13px;
    line-height: normal;
">You have successfully changed your Punchcard subscription to {{ $version }}!</p>
			<p style="
    font-size: 13px;
    color: #333232;
    margin-bottom: 0px;
">
@if($ccNumber != 'NA')
Your billing cycle has been updated with CC ending in {{ $ccNumber }} with {{ $next_billing_date }} as your billing date.
@else
Your billing cycle has been updated with {{ $next_billing_date }} as your billing date.
@endif

</p>

<p>Let us know you have any questions.</p>
				
		
			<h4 style="
    margin-bottom: 5px;
">Thanks!</h4>
			<img style="width: 50;" src="{{ url('/images/logo1.png')}}" style="
    width: 50px;
">
			<address style="
    color: #555;
    font-size: 13px;
">
				Punchcard Account Administration<br>
			    1680 Fruitville Rd<br>
			    Suite 204<br>
			    Sarasota, FL 34236<br>
			    T: (877) 851-2442<br>
			    P: (941) 702-6070<br>
			    F: (941) 702-6075<br>
			    <a href="" style="
    color: #1473be;
    text-decoration: none;
    font-style: normal;
">admin@punchcardllc.com</a><br>
			    <a href="" style="
    color: #1473be;
    text-decoration: none;
    font-style: normal;
">www.punchcardllc.com</a><br>
			    <br>
			    <br>
			    © 2018 Punchcard LLC
			</address>
		</td>
	</tr>
</tbody></table>


   </body>
</html>
   