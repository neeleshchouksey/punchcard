<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    .container {
    width: 100%;
    max-width: 1170px;
    margin: 0px auto;
    padding: 0px 15px;
}

  .payment-renew {
    position: absolute;
top: 165px;
left: 25%;
width: 350px;
    /* height: 325px; */
background: #FFF;
padding: 10px;
text-align:center;
    box-shadow: 0 1px 8px 0 rgba(0,0,0,.2), 0 3px 4px 0 rgba(0,0,0,.14), 0 3px 3px -2px rgba(0,0,0,.12);
  }
    .head{
      height: 148px;
      background: #ffd776;
    }

      .text{
        text-align: center;
        font-size: 19px;
        font-weight: 600;
        margin-top: 10px
      }

</style>
<template>
<div class="main-content">
  <div class="container payment-details">

    <div class="payment-renew">
      <div class="head">
        <i class="fa fa-exclamation-triangle" style=" font-size: 65px; text-align: -webkit-center; padding: 45px 117px; "></i>
      </div>
      <div class="text">{{message}}</div>
      <div class="row">

        <div class="col-sm-4 input-like">
          <button><router-link  class='nav-title' to="/logout">EXIT</router-link></button>
        </div>

        <div class="input-like" v-if="showBtn == 'trialExpired' || showBtn == 'unsubscribe'">
          <button><router-link  class='nav-title' to="/payment">Resubscribe</router-link></button>
        </div>
        <div class="input-like" v-if="showBtn == 'updatecard'">
          <button><router-link  class='nav-title' to="/updatecarddetails">Update Payment Info</router-link></button>
        </div>

      </div>
    </div>
  </div>
</div>
</template>
<script>
import UX from '../../helpers/UX';

export default {
  name: 'PaymentWarning',
  data() {
    return {
      message: "",
      showBtn : ""
    }
  },
  created() {

    if(User.profileData.client.plan_test == 'trialExpired'){
      this.showBtn = "trialExpired";
      this.message = "Your Punchcard Trial has expired on "+Moment(User.profileData.client.created_at).add(30, 'days').format("DD-MM-YYYY")+". To reactivate your account, please resubscribe today.";
    } else if(User.profileData.client.plan_test == 'unsubscribe') {
      this.showBtn = "unsubscribe";
      this.message = "You previously unsubscribed from PunchCard, If you would like to continue using PunchCard, please resubscribe, select plan and enter your billing information.";
    } else if (User.profile().client.creditCardDeactivateDate != null) {
      if (new Date().getTime() > new Date(User.profile().client.creditCardDeactivateDate).getTime()) {
        this.showBtn = "updatecard";

        var hours = Math.abs(User.profileData.client.creditCardDeactivateDate - new Date().getTime()) / 36e5;
        console.log("hours:  ", hours);
        if(!hours || hours == NaN){
          hours = 0;
        }
        // this.message = "Oops! It appears the CC was declined on "+User.profileData.client.creditCardDeactivateDate+". You have "+hours+" to  update your payment information before your account is deactivated. To update your payment info"
        this.message = "Oops! Something went wrong with your payment and your Credit Card information needs to be updated. To reactivate your account, please update your payment at the link below"
      }
    } else {
      this.showBtn = "";
      this.message = "Something went wrong , Try again";
    }
  },
  destroyed() {},
  methods: {},
  computed: {}
}
</script>
