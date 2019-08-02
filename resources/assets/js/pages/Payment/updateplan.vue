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
  .currentplan{
    border: 1px solid #DDD;
    height: 40px;
    width: 100px;
    text-align: center;
    padding: 6px;
    z-index: 99;
    position: absolute;
    background: #f9f9f9;
    top: 0px;
    border-radius: 5px 5px 0px 0px;
  }
  .currentplan1 {
    border: 1px solid #DDD;
    height: 40px;
    width: 100px;
    text-align: center;
    padding: 6px;
    z-index: 99;
    position: absolute;
    background: #ffffff;
    bottom: 0px;
    border-radius: 0px 0px 5px 5px;
}
</style>
<template>
<div class="main-content">
  <div class="container payment-details">
    <h1 class="page-heading">Punchcard Plans & Pricing</h1>

    <api-form style="display:none;" id="upgradebaseNewForm" name="upgradebaseNewForm" method="POST" :action="formAction" v-model="checkout" v-on:form-complete="formComplete">

      <input name="version" v-model="checkout.version"/>
      <input name="user_id" v-model="checkout.user_id" />
      <input name="client_id" v-model="checkout.client_id" />

      <input class="primary-button btn" type="submit" id="formSubmitButton" value="Upgrade Plan" />
    </api-form>

    <div class="row">
      <div class="col-sm-6">
        <div style="height: 39px;">
          <div v-if="isCurrentPlan('base')" class="currentplan" style="border-bottom:none">Current Plan</div>
        </div>
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

          <button class="upgrade-btn" type="submit" :disabled="isCurrentPlan('base')" @click.stop.prevent="submitPlan('base')">Upgrade Plan</button>

        </div>

        <div style="height: 39px;">
          <div v-if="isCurrentPlan('base')" class="currentplan1" style="border-top:none">Current Plan</div>
        </div>
      </div>
      <div class="col-sm-6">
        <div style="height: 39px;">
          <div v-if="isCurrentPlan('standard')" class="currentplan" style="border-bottom:none">Current Plan</div>
        </div>
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
          <button class="upgrade-btn" type="submit" :disabled="isCurrentPlan('standard')" @click.stop.prevent="submitPlan('standard')">Upgrade Plan</button>
        </div>

        <div style="height: 39px;">
          <div v-if="isCurrentPlan('standard')" class="currentplan1" style="border-top:none">Current Plan</div>
        </div>
      </div>
      <div class="col-3" style="display:none">
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
          <button class="upgrade-btn" type="submit" :disabled="isCurrentPlan('premium')" @click.stop.prevent="submitPlan('premium')">Upgrade Plan</button>
        </div>
      </div>
      <div class="col-3"  style="display:none">
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

          <button class="upgrade-btn" type="submit" :disabled="isCurrentPlan('enterprise')" @click.stop.prevent="submitPlan('enterprise')">Upgrade Plan</button>

        </div>
      </div>
    </div>
    </api-form>
  </div>

  <div class="modal fade" id="ungradeconfirm-modal" tabindex="-1" role="dialog">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button " class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <div style="font-size: 24px;margin: 10px 0px 13px 0px;">Upgrade Confirmation</div>
              </div>

              <div class="modal-body">
                <div style="font-size: 22px;margin-left: 10px;">Do you really want to upgrade?</div>
              </div>

              <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  <button type="button" class="btn btn-primary" @click="confirmUpgrade">
                      Upgrade
                  </button>
              </div>
          </div>
      </div>
  </div>


</div>
</template>
<script>
import UX from '../../helpers/UX';
import ApiForm from '../../components/ApiForm.vue'
import Config from '../../config'

export default {
  name: 'updateplan',
  data() {
    return {
      formAction : Config.domainName+"api/crons/punchcardupgrade",
      checkout: {
        version: 'enterprise',
        user_id: User.profileData.id,
        client_id: User.profileData.client_id,
      }
    }
  },
  created() {},
  destroyed() {},
  methods: {
    submitPlan : function(plan){
      this.checkout.version = plan;

      console.log('in submitPlan: ', plan, this.checkout);
        $('#ungradeconfirm-modal').modal('show');
    },
    confirmUpgrade : function(){
      $('#ungradeconfirm-modal').modal('hide');
      document.getElementById('formSubmitButton').click();
    },
    isCurrentPlan: function(plan) {
      console.log("this.$route.params.currentplan: ", this.$route.params.currentplan)
      if (this.$route.params.currentplan != plan) {
        return false;
      } else {
        return true;
      }
    },
    formComplete: function(value, response) {
      this.error_list = [];
      if (response.status == 200 && response.body.result == "success") {
        this.edit_mode = false;
        if (response.body.result == "success") {

          this.$store.dispatch('showAlertSuccess', {
            title: 'Plan Upgraded.',
            msg: null
          })
          this.$router.push({
            name: 'profile'
          })
        }
      } else {
        this.$store.dispatch('showAlertFail', {
          title: 'Error in upgrade',
          msg: response.body.data
        })
      }
    },
  },
  computed: {},
  components: {
    ApiForm
  }
}
</script>
