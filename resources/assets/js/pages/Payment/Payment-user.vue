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
width: 320px;
height: 325px;
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
    <!-- <div class="payment-renew">
      <h1 class="page-heading">{{message}}</h1>
    </div> -->

    <div class="payment-renew">
    <div class="head">
      <i class="fa fa-exclamation-triangle" style=" font-size: 65px; text-align: -webkit-center; padding: 45px 117px; "></i>
    </div>
    <div class="text">{{message}}</div>
    <div class="input-like">

        <button><router-link  class='nav-title' to="/logout">OK</router-link></button>
        <!-- <input type="button" class="btn" value="OK"> -->
    </div>
    </div>
  </div>
</div>
</template>
<script>
import UX from '../../helpers/UX';

export default {
  name: 'paymentrequired',
  data() {
    return {
      message : ""
    }
  },
  created() {
    if(User.profileData.client.plan_test == 'trialExpired'){
      this.message = "Your Trial period is over. Please updgrade it.";
    } else if(User.profileData.client.plan_test == 'unsubscribe') {
      this.message = "Status Unsubscribed, please contact your client admin or contact PunchCard support.";
    } else{
      this.message = "Please contact your client admin or contact PunchCard support..";
    }
  },
  destroyed() {},
  methods: {},
  computed: {}
}
</script>
