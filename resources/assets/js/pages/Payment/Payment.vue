<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    .container {
    width: 100%;
    max-width: 1170px;
    margin: 0px auto;
    padding: 0px 15px;
}
h1.page-heading {
    margin: 0px 0px;
    padding: 30px 0px;
    font-size: 24px;
    font-weight: 400;
}
.col-3 {
    width: 25%;
    padding: 0px 15px;
    display: block;
    float: left;
}
.row {
    margin: 0px -15px;
}
.plan-detain {
    padding: 0px 15px;
    border: solid 1px #ecebeb;
    border-radius: 5px;
    transition: all 0.4s ease-in-out;
    -webkit-transition: all 0.4s ease-in-out;
    -moz-transition: all 0.4s ease-in-out;
}
.plan-detain .plan-name {
    text-align: center;
    margin: 0px -15px;
    border-bottom: solid 1px #ecebeb;
    background: #f9f9f9;
}
.plan-detain .plan-name h3 {
    font-weight: 400;
    margin: 0px;
    padding: 20px 0px;
}
.plan-detain .plan-name p {
    font-weight: 600;
    color: #000000;
    margin-top: 0px;
}
.plan-detain .plan-name p
 em {
    color: #999;
    font-weight: 400;
    font-size: 12px;
}
.plan-option h4 {
    margin: 0px;
    font-size: 18px;
    font-weight: 400;
    padding: 15px 0px;
}

.plan-option ul {
    margin: 0px;
    padding: 0px;
    list-style: none;
}
.plan-option ul li {
    position: relative;
    font-size: 15px;
    padding: 8px 0px 8px 25px;
    color: #555;
    border-bottom: dashed 1px #efefef;
}
.plan-option ul li i.fa {
    position: absolute;
    left: 0px;
}
.plan-option ul li i.fa.fa-check {
    color: green;
}
.plan-option ul li i.fa.fa-times {
    color: #d82727;
}

.payment-details h4 {
    padding: 15px 0px;
    margin: 0 !important;
    background: none !important;
    box-shadow: none;
}

.payment-details h3 {
    font-size: 20px;
}

button.upgrade-btn {
    width: 100%;
    height: auto;
    display: block;
    padding: 10px;
    margin: 15px 0px;
    background: #e6a917;
    border: solid 2px #e6a917;
    font-size: 18px;
    border-radius: 5px;
    color: #fff;
    font-weight: 400;
    cursor: pointer;
    transition: all 0.4s ease-in-out;
    -webkit-transition: all 0.4s ease-in-out;
    -moz-transition: all 0.4s ease-in-out;
}
.main-content:after {
    content: "";
    display: block;
    clear: both;
}
.main-content {
    padding-bottom: 50px;
}
button.upgrade-btn:hover {
    color: #e6a917;
    background: #fff;
}
.plan-detain{
background: #FFF;
}
.plan-detain:hover {box-shadow: 1px 1px 25px 0px rgba(101, 101, 101, 0.1);}

@media only screen and (max-width: 990px){
	.col-3 {
	    width: 50%;
	    padding: 0px 15px;
	    display: block;
	    float: left;
	    margin-bottom: 20px;
	}
}
@media only screen and (max-width: 480px){
	.col-3 {
	    width: 100%;
	    padding: 0px 15px;
	    display: block;
	    float: left;
	}
}
</style>
<template>
    <div class="main-content">
		<div class="container payment-details">
			<h1 class="page-heading">{{message}}, Punchcard Plans & Pricing</h1>
			<div class="row">
				<div class="col-sm-6">
					<div class="plan-detain">
						<div class="plan-name">
							<h3>Punchcard BASE</h3>
							<p>Tier 1 Pricing<br>$1 / user / mo<br>
							<em>After 30 day trial, prompt to pay</em></p>
						</div>
						<div class="plan-option">
							<h4>Web App Access</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Client Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>User Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Team assignment</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Geofence setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Data Import</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Historic Time Entry</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Mobile App</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Access Manual Punch</li>
							</ul>
						</div>
						<div class="plan-option">
							<h4>Additional Features</h4>
							<ul>
								<li><i class="fa fa-times" aria-hidden="true"></i>Digital Badge</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Badge Scan</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Auto Punch</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Face Punch</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Payroll</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Task Management</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Reporting</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Timesheet</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Employees Onsite</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Punches</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Detail</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Late</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Overtime</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Location</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Estimated Payroll</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Analytics</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Data Storage (AWS)</h4>
							<ul>
								<li><i class="fa fa-times" aria-hidden="true"></i>Logs & Photos</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Project Documents</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Project Archive</li>
								<li style="border:none;">&nbsp;</li>
							</ul>
						</div>
						<router-link :to="{ path: '/checkout/base', meta: {}}">
							<button class="upgrade-btn">Upgrade Plan</button>
						</router-link>

					</div>
				</div>
				<div class="col-sm-6">
					<div class="plan-detain">
						<div class="plan-name">
							<h3>Punchcard STANDARD</h3>
							<p>Tier 2 Pricing<br>$2 / user / mo<br>
							<em>After 30 day trial, prompt to pay</em></p>
						</div>
						<div class="plan-option">
							<h4>Web App Access</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Client Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>User Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Team assignment</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Geofence setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Data Import</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Historic Time Entry</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Mobile App</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Access Manual Punch</li>
							</ul>
						</div>
						<div class="plan-option">
							<h4>Additional Features</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Digital Badge</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Badge Scan</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Auto Punch</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Face Punch</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Payroll</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Task Management</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Reporting</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Timesheet</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Employees Onsite</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Punches</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Late</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Overtime</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Location</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Estimated Payroll</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Analytics</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Data Storage (AWS)</h4>
							<ul>
								<li><i class="fa fa-times" aria-hidden="true"></i>Logs & Photos</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Project Documents</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Project Archive</li>
								<li style="border:none;">&nbsp;</li>
							</ul>
						</div>
						<router-link :to="{ path: '/checkout/standard', meta: {}}">
							<button class="upgrade-btn">Upgrade Plan</button>
						</router-link>
					</div>
				</div>
				<div  style="display:none" class="col-3">
					<div class="plan-detain">
						<div class="plan-name">
							<h3>Punchcard PREMIUM
</h3>
							<p>Tier 3 Pricing<br>$3 / user / mo<br>
							<em>After 30 day trial, prompt to pay</em></p>
						</div>
						<div class="plan-option">
							<h4>Web App Access</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Client Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>User Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Team assignment</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Geofence setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Data Import</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Historic Time Entry</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Mobile App</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Access Manual Punch</li>
							</ul>
						</div>
						<div class="plan-option">
							<h4>Additional Features</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Digital Badge</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Badge Scan</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Auto Punch</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Face Punch</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Payroll</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Task Management</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Reporting</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Timesheet</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Employees Onsite</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Punches</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Detail</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Late</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Overtime</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Employee Location</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Estimated Payroll</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Analytics</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Data Storage (AWS)</h4>
							<ul>
								<li><i class="fa fa-times" aria-hidden="true"></i>Logs & Photos</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Project Documents</li>
								<li><i class="fa fa-times" aria-hidden="true"></i>Project Archive</li>
								<li style="border:none;">&nbsp;</li>
							</ul>
						</div>
						<router-link :to="{ path: '/checkout/premium', meta: {}}">
							<button class="upgrade-btn">Upgrade Plan</button>
						</router-link>
					</div>
				</div>
				<div  style="display:none" class="col-3">
					<div class="plan-detain">
						<div class="plan-name">
							<h3>Punchcard ENTERPRISE</h3>
							<p>Tier 4 Pricing<br>$4 / user / mo<br>
							<em>After 30 day trial, prompt to pay</em></p>
						</div>
						<div class="plan-option">
							<h4>Web App Access</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Client Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>User Setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Team assignment</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Geofence setup</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Data Import</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Historic Time Entry</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Mobile App</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Access Manual Punch</li>
							</ul>
						</div>
						<div class="plan-option">
							<h4>Additional Features</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Digital Badge</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Badge Scan</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Auto Punch</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Face Punch</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Payroll</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Task Management</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Reporting</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Timesheet</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Company Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Summary</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Hours Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Employees Onsite</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Punches</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Detail</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Late</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Overtime</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Employee Location</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Estimated Payroll</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Analytics</li>
							</ul>
						</div>

						<div class="plan-option">
							<h4>Data Storage (AWS)</h4>
							<ul>
								<li><i class="fa fa-check" aria-hidden="true"></i>Logs & Photos</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Documents</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Project Archive</li>
								<li><i class="fa fa-check" aria-hidden="true"></i>Live Scribe integration</li>
							</ul>
						</div>
						<router-link :to="{ path: '/checkout/enterprise', meta: {}}">
							<button class="upgrade-btn">Upgrade Plan</button>
						</router-link>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
    import UX from '../../helpers/UX';

    export default {
        name: 'payment',
        data () {
            return {
              message : ""
            }
        },
        created () {

          if(User.profileData.client.plan_test == 'trialExpired'){
            this.message = "Your Punchcard Trial has expired on "+Moment(User.profileData.client.created_at).add(30, 'days').format("DD-MM-YYYY")+". To reactivate your account, please resubscribe today.";
          } else if(User.profileData.client.plan_test == 'unsubscribe') {
            this.message = "You previously unsubscribed from PunchCard, If you would like to continue using PunchCard, please resubscribe, select plan and enter your billing information";
          }
        },
        destroyed () {},
        methods: {},
        computed: {}
    }
</script>
