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
		<img src="{{ url ('images/logo1.png') }}">	
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
">Thank you for your payment of ${{ $totalAmount }} on {{ $Billing_Cycle_Date }}!</p>
			<p style="
    font-size: 13px;
    color: #333232;
    margin-bottom: 0px;
">Below is a summary of Punchcard Activity Summary for {{ $companyName }} ({{ $companyName }}.punchcardllc.com).</p>

<ul style="
    font-size: 13px;
    color: #333232;
    margin-bottom: 10px;
    margin-top: 10px;
">
    <li style="font-weight: bold;">Number of active users: {{ $totalActiveUsers }}</li>
    <li style="font-weight: bold;">Total Cost: {{ $totalAmount }}</li>
    <li style="font-weight: bold;">Cost Per User : {{ $costperuser }}</li>
   
</ul>
			
<p>Summary of activity:</p>

<ul style="
    font-size: 13px;
    color: #333232;
    margin-bottom: 10px;
    margin-top: 10px;
">
    <li>Number of total users: {{ $totalUsers }}</li>
    <li>Number of punches: {{ $totalPunchs }}</li>
    <li>Number of hours tracked: {{ $totalHours }}</li>
    <li>Number of Child Companies: {{ $totalChildCompanies }}</li>
    <li>Number of Child Company Users: {{ $totalChildCompaniesUsers }}</li>
</ul>
<p>Let us know if you have any questions!</p>
				
	
			<p style="
    font-size: 13px;
    color: #333232;
">Thank you for your business!</p>

			

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
   