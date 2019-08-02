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
">"Oops!  Something went wrong and your account has been deactivated.{{ $companyName }} subscribed to Punchcard {{ $subscriptionTier }} on {{ $subscriptionDate }} BUT your Credit Card information needs to be updated for Punchcard {{ $subscriptionTier }}.</p>
			<p style="
    font-size: 13px;
    color: #333232;
    margin-bottom: 0px;
">Link to {{ $companyName }}.punchcardllc.com
</p>
			<div style="
    text-align: center;
">
<p>{{ $companyName }}.punchcardllc.com subscription will expire on {{ $deactivatedDate }}.</p>
				
			</div>
<p style="
    font-size: 13px;
    color: #333232;
">Let us know you have any questions.</p>

			<h4 style="
    margin-bottom: 5px;
">Thanks!</h4>
			<img src="{{ url ('images/logo1.png')}}" style="
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
   