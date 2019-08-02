<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
</style>
<template>
<div class="main-wrapper">

  <!-- main-content -->
  <div class="main-content">
    <div class="container" style="width:100%">
      <h1 class="page-heading">Punchcard Plans & Pricing</h1>
      <div v-if="computedErros" style="margin-bottom: 25px;border: 1px solid #DDD;padding: 20px;">
        <div style="font-size: 20px;color: red;">Errors</div>
        <div class="row" v-for="error in computedErros">
            <div class="col-sm-2">{{error.field}}</div>
            <div class="col-sm-2">{{error.issue}}</div>
        </div>
      </div>
      <api-form id="checkout-new-form" method="POST" :action="formAction" v-model="checkout" v-on:form-complete="formComplete">
        <input type="hidden" name="version" v-model="checkout.version" />
        <input type="hidden" name="user_id" v-model="checkout.user_id" />
        <input type="hidden" name="client_id" v-model="checkout.client_id" />
        <input type="hidden" name="plan_test" v-model="checkout.plan_test" />
        <input type="hidden" name="billing_address.country_code" v-model="checkout.billing_address.country_code" />

        <checkout-form :checkout="checkout" :edit_mode="edit_mode"></checkout-form>

        <div class="row">
          <div class="col-xs-6">
            <input class="primary-button btn" type="submit" value="Subscribe Now" />
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
import UX from '../../helpers/UX';
import ApiForm from '../../components/ApiForm.vue'
import CheckoutForm from './checkout-form.vue'
import AjaxForm from '../../components/Form.vue'
import Config from '../../config'

export default {
  name: 'checkout',
  data() {
    return {
      formAction : Config.domainName+"api/crons/punchcardSubscription",
      checkout: {
        number: '',
        type: '',
        expire_month: '',
        expire_year: '',
        cvv2: '',
        first_name: '',
        last_name: '',
        version: this.$route.params.plan,
        user_id: User.profileData.id,
        client_id: User.profileData.client_id,
        plan_test: User.profileData.client.plan_test,
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
    }
  },
  created() {},
  methods: {
    formComplete: function(value, response) {
      this.error_list = [];
      if (response.status == 200 && response.body.result == "success") {
        this.edit_mode = false;
        if (response.body.result == "success") {
          var date = Moment(Moment(new Date()).add(30, 'd'));
          date = date.format('DD MMM');
          var titleMsg = 'Thank you for your CC info you will be billed for active users when your billing cycle ends on '+date+".";
          this.$store.dispatch('showAlertSuccess', {
            title: titleMsg,
            msg: null
          })
          setTimeout(function () {
            window.location.replace(DevConfig.hash + '/projects');
          }.bind(this), 2000)

          /*this.$router.push({
            name: 'projects'
          })*/
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
        /*this.$store.dispatch('showAlertFail', {
          title: 'Error',
          msg: 'test'
        });*/
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
