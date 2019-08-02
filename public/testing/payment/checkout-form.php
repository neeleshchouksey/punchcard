<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Panchcard</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link href="creditcardjs-v0.10.13/creditcardjs-v0.10.13.min.css" rel="stylesheet">
</head>
<style type="text/css">
	.col-8 {
    width: 66%;
    padding: 0px 15px;
}
.subscriber-form {
    border: solid 1px #efefef;
    padding: 15px;
    background: #f9f9f9;
}
.subscriber-form .form-group {
    width: 50%;
    float: left;
    padding: 10px 10px;
}
.subscriber-form .form-group.credit_card, .subscriber-form .form-group.expiry {
    width: 100%;
    float: none;
    padding: 10px 10px;
}
.subscriber-form .form-group label {
    width: 100%;
    display: block;
    font-size: 13px;
    margin-bottom: 5px;
}
.subscriber-form .form-group input[type="text"] {
    width: 100%;
    height: 30px;
    padding: 5px 10px;
    border: solid 1px #ddd;
}
.subscriber-form .form-group.expiry input[type="text"], .subscriber-form .form-group.credit_card input[type="text"] {
    width: auto;
}
button.pay-now-btn {
    margin: 10px auto;
    width: 150px;
    padding: 10px 10px;
    background: #e6a917;
    color: #fff;
    font-size: 15px;
    border: solid 2px #e6a917;
    border-radius: 0px;
    display: block;
}
.subscriber-form .form-group {}

.subscriber-form .form-group.credit-card-sec {
    width: 50%;
    float: none;
    clear: both;
}

.subscriber-form .form-group.credit-card-sec .ccjs-card.credit-card-sec.ccjs-js-enabled {
    width: 100% !important;
    margin: 0px;
    border: none;
    height: auto !important;
    background: #fdf6e5;
    padding: 10px;
    border: solid 1px #ddd;
    border-radius: 0px;
    box-sizing: border-box;
}

.subscriber-form .form-group.credit-card-sec label.ccjs-number {
    position: relative;
    height: 60px;
    line-height: normal;
    display: inline-block;
    top: 0px;
    left: 0px;
    float: left;
    padding-right: unset;
}

.subscriber-form .form-group.credit-card-sec label.ccjs-number input {
    width: 100%;
    position: absolute;
    left: 0px;
    right: 0px;
    box-sizing: border-box;
    padding: 5px 10px;
}

.subscriber-form .form-group.credit-card-sec label.ccjs-csc {
    position: relative;
    display: block;
    text-align: left;
    left: 0px;
    height: 60px;
    vertical-align: top;
    white-space: normal;
    top: 0px;
}

.subscriber-form .form-group.credit-card-sec label.ccjs-csc input.ccjs-csc {
    top: 21px;
    left: 0px;
    width: 35px;
    text-align: center;
}

.subscriber-form .form-group.credit-card-sec button.ccjs-csc-help {
    position: static;
}

.subscriber-form .form-group.credit-card-sec fieldset.ccjs-expiration.ccjs-error {
    position: static;
    width: 200px;
    height: auto;
    line-height: normal;
}

.subscriber-form .form-group.credit-card-sec fieldset.ccjs-expiration.ccjs-error select {
    position: static;
    display: inline-block;
}

.subscriber-form .form-group.credit-card-sec fieldset.ccjs-expiration.ccjs-error select#yr {
    margin-left: 10px;
}

.subscriber-form .form-group.credit-card-sec label.ccjs-csc {
    display: inline-block;
}

.ccjs-card .ccjs-expiration:after {
    left: 68px;
}
@media only screen and (max-width: 767px){
	.col-8 {
	    width: 100%;
	    padding: 0px 15px;
	}
}
</style>
<body>
<div class="main-wrapper">

	<!-- header -->
	<nav class="top-header navbar">
		<div class="container">
			<div class="navbar-header">
				<span>Punchcard</span>
			</div> 
			<div id="navbar">
				<ul class="nav-top"> 
					<li >
						<a href="/logout" class="nav-title"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>


	<!-- main-content -->
	<div class="main-content">
		<div class="container">
			<h1 class="page-heading">Punchcard Plans & Pricing</h1>
			<div class="row">
				<div class="col-8">

            <?php if(isset($_GET['msg']) && $_GET['msg']=='suc'){ ?>
				<div class="alert alert-success">
				  <strong>Success!</strong> Card Details Saved on Paypal Securely.Ref.Id-<?php echo $_GET['cid'];?>
				</div>
            <?php } ?>
            <!--
				<div class="alert alert-info">
				  <strong>Info!</strong> Indicates a neutral informative change or action.
				</div>

				<div class="alert alert-warning">
				  <strong>Warning!</strong> Indicates a warning that might need attention.
				</div>
            -->
             <?php if(isset($_GET['msg']) && $_GET['msg']=='err'){ ?>
				<div class="alert alert-danger">
				  <strong>Error!</strong>Please enter correct values.
				</div>
            <?php } ?>

					<div class="subscriber-form">
						<form method="post" action="paypalVault.php">
							<div class="form-group">
								<label>First Name</label>
								<input type="text" name="first_name" required />
							</div>
							<div class="form-group">
								<label>Last Name</label>
								<input type="text" name="last_name" required />
							</div>
							<div class="form-group">
								<label>Phone Number</label>
								<input type="text" name="phone" required />
							</div>
							<div class="form-group">
								<label>Billing Address </label>
								<input type="text" name="line1">
							</div>
							<div class="form-group">
								<label>Postal Code</label>
								<input type="text" name="postal_code">
							</div>
							<div class="form-group">
								<label>City</label>
								<input type="text" name="city">
							</div>
							<div class="form-group">
								<label>State</label>
								<input type="text" name="state">
							</div>
							<div class="form-group">
								<label>Country</label>
								<input type="text" name="country_code" value="US">
							</div>
							
							<!-- <div class="form-group credit_card">
								<label>Credit Card</label>
								<input class="inputCard" type="number" min="1000" max="9999" name="creditCard1" id="creditCard1" required/>
                                -
						        <input class="inputCard" type="number" min="1000" max="9999" name="creditCard2" id="creditCard2" required/>
						        -
						        <input class="inputCard" type="number" min="1000" max="9999" name="creditCard3" id="creditCard3" required/>
						        -
						        <input class="inputCard" type="number" min="1000" max="9999"  name="creditCard4" id="creditCard4" required/>
							</div>
							<div class="form-group expiry">
								<label> Card Expiry Date</label>
								<input class="inputCard" name="expiry" id="expiry" type="month" required/>
							</div> -->
							<div class="form-group credit-card-sec">
							<input type="hidden" name="EXPDATE" id="exdate" value="">   <!-- #Expiration date of the credit card-->

                            <input type="hidden" name="plan"  value="<?php echo $_GET['plan'];?>">
							<div class="ccjs-card credit-card-sec">
							  <label class="ccjs-number">
							    Card Number
							    <input name="card_number" class="ccjs-number" placeholder="•••• •••• •••• ••••" required />
							  </label>

							  <label class="ccjs-csc">
							    Security Code
							    <input name="cvv2" class="ccjs-csc" placeholder="•••" required />
							  </label>

							  <button type="button" class="ccjs-csc-help">?</button>

							  <label class="ccjs-name" style="display:none;">
							    Name on Card
							    <input name="first_names" class="ccjs-name">
							    <input name="last_names" class="ccjs-name">
							  </label>

							  <fieldset class="ccjs-expiration">
							    <legend>Expiration</legend>
							    <select name="expire_month" id="mnth" onchange="return expireDate();" class="ccjs-month" required />
							      <option value="" selected disabled>MM</option>
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

							    <select name="expire_year" id="yr" onchange="return expireDate();" class="ccjs-year" required />
							      <option value="" selected disabled>YY</option>
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

							  <select name="card_type" class="ccjs-hidden-card-type" required />
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
							</div>
							<button type="submit" class="pay-now-btn">Subscribe Now</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
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