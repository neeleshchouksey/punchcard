<!DOCTYPE html>
<html lang="en" class="">
	<!-- BEGIN HEAD -->
	<head>
		<meta charset="utf-8"/>
		<title>Punchcard</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="width=device-width, initial-scale=1" name="viewport"/>
		<meta content="" name="Punchcard"/>
		<meta name="description" content="Punchcard"/>
		
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
		<link href='http://fonts.googleapis.com/css?family=Roboto:100,400,300,500,700' rel='stylesheet' type='text/css'>
		<link href="creditcardjs-v0.10.13/creditcardjs-v0.10.13.min.css" rel="stylesheet">
		
	</head>
	
	<body quick-markup_injected="true">



<form action="https://api-3t.sandbox.paypal.com/nvp" method="POST">
<input type="text" name="VERSION" value="65.1">
<input type="text" name="USER" value="palash3593agrawal_api2.gmail.com">
<input type="text" name="PWD" value="CBGBLW2TLE7NURUG">
<input type="text" name="SIGNATURE" value="AFcWxV21C7fd0v3bYYYRCpSSRl31AjJQ-gPVvkzZ5Ow-GntgF58d2UqE">
<input type="text" name="METHOD" value="CreateRecurringPaymentsProfile">
<input type="text" name="PROFILESTARTDATE" value="2017-11-15T00:00:00Z">
<input type="text" name="DESC" value="RacquetClubMembership"><!--    #Profile description - same value as a billing agreement description-->
<input type="text" name="BILLINGPERIOD" value="Month">   <!-- #Period of time between billings-->
<input type="text" name="BILLINGFREQUENCY" value="1">   <!-- #Frequency of charges-->
<input type="text" name="AMT" value="10">   <!-- #The amount the buyer will pay in a payment period-->
<input type="text" name="MAXFAILEDPAYMENTS" value="3">   <!--#Maximum failed payments before suspension of the profile-->
 <!--<input type="text" name="ACCT" value="4641631486853053">   #The credit card number-->
<!--<input type="text" name="CREDITCARDTYPE" value="VISA">   #The type of credit card-->
<!--<input type="text" name="CVV2" value="123">   #The CVV2 number-->
<input type="text" name="FIRSTNAME" value="James">
<input type="text" name="LASTNAME" value="Smith">
<input type="text" name="STREET" value="FirstStreet">
<input type="text" name="CITY" value="SanJose">
<input type="text" name="STATE" value="CA">
<input type="text" name="ZIP" value="95131">
<input type="text" name="COUNTRYCODE" value="US">  <!-- #The country code, e.g. US-->
<input type="text" name="CURRENCYCODE" value="USD">   <!-- #The currency, e.g. US dollars-->
<input type="text" name="EXPDATE" id="exdate" value="">   <!-- #Expiration date of the credit card-->


<div class="ccjs-card">
  <label class="ccjs-number">
    Card Number
    <input name="ACCT" class="ccjs-number" placeholder="•••• •••• •••• ••••">
  </label>

  <label class="ccjs-csc">
    Security Code
    <input name="CVV2" class="ccjs-csc" placeholder="•••">
  </label>

  <button type="button" class="ccjs-csc-help">?</button>

  <label class="ccjs-name">
    Name on Card
    <input name="FIRSTNAME" class="ccjs-name">
    <input name="LASTNAME" class="ccjs-name">
  </label>

  <fieldset class="ccjs-expiration">
    <legend>Expiration</legend>
    <select name="month" id="mnth" onchange="return expireDate();" class="ccjs-month">
      <option value="00" selected disabled>MM</option>
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
    </select>

    <select name="year" id="yr" onchange="return expireDate();" class="ccjs-year">
      <option value="00" selected disabled>YY</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
    </select>
  </fieldset>

  <select name="CREDITCARDTYPE" class="ccjs-hidden-card-type">
    <option value="amex" class="ccjs-amex">American Express</option>
    <option value="discover" class="ccjs-discover">Discover</option>
    <option value="mastercard" class="ccjs-mastercard">MasterCard</option>
    <option value="visa" class="ccjs-visa">Visa</option>
    <option value="diners-club" class="ccjs-diners-club">Diners Club</option>
    <option value="jcb" class="ccjs-jcb">JCB</option>
    <option value="laser" class="laser">Laser</option>
    <option value="maestro" class="maestro">Maestro</option>
    <option value="unionpay" class="unionpay">UnionPay</option>
    <option value="visa-electron" class="visa-electron">Visa Electron</option>
    <option value="dankort" class="dankort">Dankort</option>
  </select>
</div>

<input type="image" name="submit" border="0"
src="https://www.paypal.com/en_US/i/btn/btn_subscribe_LG.gif"
alt="PayPal - The safer, easier way to pay online">
<img alt="" border="0" width="1" height="1"
src="https://www.paypal.com/en_US/i/scr/pixel.gif" >
</form>
<script src="./creditcardjs-v0.10.13/creditcardjs-v0.10.13.min.js"></script>
<script>
function expireDate(){
	//alert('fgg');
	var ex_month=document.getElementById('mnth').value;
	var ex_year=document.getElementById('yr').value;
	var expdate= ex_month.concat('20'.concat(ex_year));
	document.getElementById('exdate').value=expdate;
}
</script>
</body>
</html>
