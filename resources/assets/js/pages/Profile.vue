<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    .btn-cancel:hover {
        background-color: $theme-failure-red;
        color: white;
    }
    .btn-submit:hover {
        background-color: $theme-success-green;
        color: white;
    }
    .row > * {
        float: left;
    }
</style>
<template>
<div>
  <loader :loading="loading"></loader>

  <div v-if="!loading">
    <api-form id="profile-update-form" method="PUT" action="/user" v-model="profile" v-on:form-submitting="formSubmitting" v-on:form-complete="formComplete">
      <user-detail v-if="profile" v-on:input="validateInput" v-model="profile" :role-options="roleOptions" type="profile" :edit_mode="edit_mode">
      </user-detail>

      <div class="row">

        <div v-show="showCancelButton()">
          <button class="primary-button material btn-cancel btn" @click.stop.prevent="exitEditMode">Cancel</button>
        </div>

        <div v-show="showEditButton()">
          <button class="primary-button material btn" @click.stop.prevent="enterEditMode">Edit</button>
        </div>

        <div v-if="showSaveButton()">
          <input class="primary-button material btn-submit btn" type="submit" value="Save" />
        </div>

        <router-link :to="{name: 'user-password-reset', params: { user_id: profile.uniq_id}}">
          <button class="primary-button material btn">Reset Password</button>
        </router-link>

        <router-link :to="{name: 'payment'}" v-show="profile.client.plan_test == 'trial' && showPaymentButton()">
          <button class="primary-button material btn">Subscribe</button>
        </router-link>

        <router-link :to="{name: 'updateplan', params: { currentplan: profile.client.plan_test}}" v-show="showPaymentButton()">
          <button class="primary-button material btn">Update Subscription</button>
        </router-link>

        <router-link :to="{name: 'updatecard'}" v-show="showPaymentButton()">
          <button class="primary-button material btn">Update Card Details</button>
        </router-link>

        <router-link :to="{name: 'transaction-history'}" v-show="showPaymentButton()">
          <button class="primary-button material btn">View transaction history</button>
        </router-link>

        <div v-show="showPaymentButton()">
          <button class="primary-button material btn" @click.stop.prevent="showUnsubscribeModal">Unsubscribe</button>
        </div>
      </div>
    </api-form>
  </div>

  <div class="modal fade" id="unsubscribe-modal" tabindex="-1" role="dialog">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button " class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <div style="font-size: 24px;margin: 10px 0px 13px 0px;">Unsubscribe Confirmation</div>
              </div>

              <div class="modal-body">
                <div style="font-size: 22px;margin-left: 10px;">Do you really want to unsubscribe?</div>
              </div>

              <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  <api-form style="display:none" id="checkout-new-form" method="POST" :action="formAction" v-model="unsubscribe" v-on:form-complete="unsubscribeFormComplete">
                    <input type="hidden" name="user_id" v-model="unsubscribe.user_id" />
                    <input type="hidden" name="client_id" v-model="unsubscribe.client_id" />
                    <div class="row">
                      <div class="col-xs-6">
                        <input class="primary-button btn" id="unsubscribeUserBtn" type="submit" value="Unsubscribe" />
                      </div>
                      <div class="col-xs-6">
                      </div>
                    </div>
                  </api-form>

                  <button type="button" class="btn btn-primary" @click="unsubscribeUser">
                      Unsubscribe
                  </button>
              </div>
          </div>
      </div>
  </div>
</div>
</template>
<script>
//import User from '../api/user'
import ApiForm from '../components/ApiForm.vue'
import UserDetail from '../components/UserDetail.vue'
import Config from '../config'

export default {
  name: 'profile',
  data() {
    return {
      roleOptions: [], // can't change their own role thru profile
      loading: false,
      edit_mode: false,
      profile: User.profile(),
      formAction : Config.domainName+"api/crons/punchcardUnsubscribe",
      unsubscribe: {
        user_id: User.profileData.id,
        client_id: User.profileData.client_id,
      }
    }
  },
  created() {},
  methods: {
    showUnsubscribeModal() {
        $('#unsubscribe-modal').modal('show');
    },
    unsubscribeUser() {
      $('#unsubscribe-modal').modal('hide');
      document.getElementById('unsubscribeUserBtn').click();
    },
    formSubmitting: function() {
      delete this.profile.image;
    },
    formComplete: function(profile, response) {
      this.edit_mode = false;
      Api.store('profile', profile);

      if(response.status == 200) {
          this.$store.dispatch('showAlertSuccess', {title: "Success", msg: response.data.message})
      }

    },
    showCancelButton: function() {
      return this.edit_mode
    },
    showEditButton: function() {
      return !this.edit_mode
    },
    showPaymentButton: function() {
      return !this.edit_mode && User.profileData.role == 'clientadmin'
    },
    showSaveButton: function() {
      return this.edit_mode
    },
    enterEditMode: function() {
      this.edit_mode = true;
    },
    exitEditMode: function() {
      this.edit_mode = false;
    },
    validateInput: function(data) {},
    unsubscribeFormComplete: function(profile, response) {
      if (response.status == 200 && response.body.result == "success") {
        this.$store.dispatch('showAlertSuccess', {
          title: 'Unsubscribe successfull.',
          msg: null
        })
        this.$router.push({
          name: 'logout'
        })
      } else {
        this.$store.dispatch('showAlertFail', {
          title: 'Error',
          msg: response.data.data
        });
      }
    },

  },
  components: {
    ApiForm,
    UserDetail
  }
}
</script>
