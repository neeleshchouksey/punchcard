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
">
@if($dayRemain != 0)
You have {{ $dayRemain }} days of your FREE Punchcard trial remaining.  Your trial will expire on {{ $trial_expire_date }}.
@else
"Your Punchcard Trial has expired on {{ $trial_expire_date }}.
@endif
</p>
			<p style="
    font-size: 13px;
    color: #333232;
    margin-bottom: 0px;
">Punchcard Activity Summary for {{ $companyName }} ({{ $companyName }}.punchcardllc.com).</p>
<ul style="
    font-size: 13px;
    color: #333232;
    margin-bottom: 10px;
    margin-top: 10px;
">
    <li>Number of total users: {{ $totalUsers }}</li>
    <li>Number of active users: {{ $totalActiveUsers }}</li>
    <li>Number of punches: {{ $totalPunchs }}</li>
    <li>Number of hours tracked: {{ $totalHours }}</li>
    <li>Number of Child Companies: {{ $totalChildCompanies }}</li>
    <li>Number of Child Company Users: {{ $totalChildCompaniesUsers }}</li>
</ul>
			

<p style="
    color: #333232;
    font-size: 13px;
    line-height: normal;
">Once you select a plan, you will be billed only for user activity at the end of the billing cycle.  Subscribe today {{ $companyName }}.punchcardllc.com.</p>
<p>Let us know if you have any questions!</p>
				


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
   