<style lang="sass" scoped>
    @import '../../../../sass/_variables.scss';
</style>
<template>
<div class="main-wrapper">

  <!-- main-content -->
  <div class="main-content">
    <div class="container" style="width:100%">
      <h1 class="page-heading">Update card details</h1>
      <h4 class="page-heading" v-if="isViewDeactivateMessage">{{deactivatedMessage}}</h4>

      <div v-if="computedErros" style="margin-bottom: 25px;border: 1px solid #DDD;padding: 20px;">
        <div style="font-size: 20px;color: red;">Errors</div>
        <div class="row" v-for="error in computedErros">
            <div class="col-sm-2">{{error.field}}</div>
            <div class="col-sm-2">{{error.issue}}</div>
        </div>
      </div>

      <api-form id="checkout-new-form" method="POST" :action="formAction" v-model="checkout" v-on:form-complete="formComplete">
        <input type="hidden" name="user_id" v-model="checkout.user_id" />
        <input type="hidden" name="client_id" v-model="checkout.client_id" />
        <input type="hidden" name="billing_address.country_code" v-model="checkout.billing_address.country_code" />
        <input type="hidden" name="cardRenew" v-model="checkout.cardRenew" />

        <checkout-form :checkout="checkout" :edit_mode="edit_mode"></checkout-form>

        <div class="row">
          <div class="col-xs-6">
            <input class="primary-button btn" type="submit" value="Update Details" />
          </div>
          <div class="col-xs-6">
          </div>
        </div>
      </api-form>
    </div>
  </div>
</div>
</template>
<script>
import UX from '../../../helpers/UX';
import ApiForm from '../../../components/ApiForm.vue'
import CheckoutForm from '../checkout-form.vue'
import AjaxForm from '../../../components/Form.vue'
import Config from '../../../config'

export default {
  name: 'updatecard',
  data() {
    return {
      formAction : Config.domainName+"api/crons/updateCC",
      isViewDeactivateMessage : false,
      checkout: {
        number: '',
        type: '',
        expire_month: '',
        expire_year: '',
        cvv2: '',
        first_name: '',
        last_name: '',
        user_id: User.profileData.id,
        client_id: User.profileData.client_id,
        cardRenew: User.profileData.client.creditCardDeactivateDate!=null ? true : false,

        billing_address: {
          line1: "",
          city: "",
          country_code: "US",
          postal_code: "",
          state: "",
          phone: ""
        },
      },
      edit_mode: true,
      error_list : [],
      deactivatedMessage : "",
    }
  },
  created() {

    console.log(User.profileData.role);
    console.log(User.profileData.client.creditCardDeactivateDate, User.profileData.client.creditCardDeactivateDate!=null);

    this.isViewDeactivateMessage = (User.profileData.role == 'clientadmin' &&  User.profileData.client.creditCardDeactivateDate!=null && new Date().getTime() > new Date(User.profileData.client.creditCardDeactivateDate).getTime());

    if(this.isViewDeactivateMessage){
      var hours = Math.abs(User.profileData.client.creditCardDeactivateDate - new Date().getTime()) / 36e5;
      console.log("hours:  ", hours);
      if(!hours || hours == NaN){
        hours = 0;
      }
      this.deactivatedMessage = "Oops! It appears the CC was declined on "+User.profileData.client.creditCardDeactivateDate+". You have "+hours+" hours to  update your payment information before your account is deactivated. To update your payment info"
    }
  },
  methods: {
    formComplete: function(value, response) {
      this.error_list = [];
      if (response.status == 200 && response.body.result == "success") {
        this.edit_mode = false;
        if (response.body.result == "success") {

          this.$store.dispatch('showAlertSuccess', {
            title: 'CC details has been successfully updated.',
            msg: null
          })

          window.location.replace(DevConfig.hash + '/profile');
          /*if(User.profileData.role == 'clientadmin' &&  User.profileData.client.creditCardDeactivateDate!=null && new Date().getTime() > new Date(User.profileData.client.creditCardDeactivateDate).getTime()) {
            console.log("in if");
          } else{
            console.log("in else");
            this.$router.push({
              name: 'profile'
            })
          }*/

        }
      } else {
        var json = [];
        var data = response.body.data;
        data = JSON.parse(data);
        for (var i = 0; i < data.details.length; i++) {
          var obj = {};
          obj.field = data.details[i].field;
          obj.issue = data.details[i].issue;
          json.push(obj);
        }
        this.error_list = json;
      }
    },
  },
  computed: {
    computedErros: function () {
        if (! this.error_list.length) {
            return;
        }
        let filteredErrors = this.error_list;
        return filteredErrors;
    }
  },
  components: {
    ApiForm,
    AjaxForm,
    CheckoutForm
  }
}
</script>
