<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    @import '../../sass/app.bs.css';
    #login-container {
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: $theme-white;

        background: $theme-white; /* For browsers that do not support gradients */
        background: -webkit-linear-gradient(left top, $theme-white, darken($theme-white, 20%)); /* For Safari 5.1 to 6.0 */
        background: -o-linear-gradient(bottom right, $theme-white, darken($theme-white, 20%)); /* For Opera 11.1 to 12.0 */
        background: -moz-linear-gradient(bottom right, $theme-white, darken($theme-white, 20%)); /* For Firefox 3.6 to 15 */
        background: linear-gradient(to bottom right, $theme-white, darken($theme-white, 20%)); /* Standard syntax */
        box-shadow: $main-box-shadow;
    }
    a {
        color: $theme-white;
    }
    form {
        width: 450px;
        border-radius: 4px;
        background-color: $theme-slate;
        overflow: hidden;
    }
    .header-row {
        text-align: center;
        color: $theme-gold;
        font-weight: 800;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        * {
            margin: 25px 0;
        }
    }
    .row {
        width: 100%;
        margin: 0;
        padding: 15px;
        &:last-child {
            padding-top: 0;
        }
    }
    input {
        color: $theme-slate;
    }
</style>
<template>
<div id='login-container'>
  <form action="#" name="form-login" id="form-login">
    <div class="header-row">
      <img title="IHOS Punchcard" alt="[Logo]" :src="logoSrc" width="94" height="80" />
    </div>

    <div class="row">
      <label>
                Username:
                <div class="btn-group" style="width: 100%">
                    <input v-model="username" ref="username" type="text" placeholder="Enter username, email or mobilenumber" />
                    <span @click="valueClear('username')" class="value-clear fa fa-remove"></span>
                </div>
            </label>

      <label>
                Password:
                <div class="btn-group" style="width: 100%">
                    <input v-model="pwd" ref="pwd" type="password" placeholder="Enter password" />
                    <span @click="valueClear('pwd')" class="value-clear fa fa-remove"></span>
                </div>
            </label>
    </div>

    <div class="row">
      <input @click.prevent="doLogin" type="submit" value="Login" class="primary-button material btn" style="margin-left: 0" />
      <a :href="passwordResetLink">Forgot your password?</a>
    </div>
  </form>
</div>
</template>
<script>
//import User from '../api/user'

export default {
  name: 'login',
  data() {
    return {
      location: null,
      username: '',
      pwd: ''
    }
  },
  created() {
    //
    // If logged in, redirect to projects page for landing
    //
    if (User.auth()) {
      window.location.replace(DevConfig.hash + '/projects');
    }
  },
  computed: {
    logoSrc: function() {
      return DevConfig.url + 'images/logo.png'
    },
    location: function() {
      return window.location.href
    },
    passwordResetLink: function() {
      return DevConfig.hash + '/password/reset/';
    }
  },
  components: {},
  methods: {
    valueClear: function(whichRef) {
      this.$refs[whichRef].value = '';
    },
    doLogin: function() {

      let subdomain = null
      let routes = Api.getRoutes('webapp-user');

      this.$store.dispatch('showAlertInfo', {
        title: 'Logging in...'
      });
      routes.login.post(this.username.trim(), this.pwd.trim()).then((response) => {
        if (response) {
          let AuthResponse = response.body;

          Api.rebuild(AuthResponse);

          routes.profile.get().then((responseBody) => {
            routes.login.save(AuthResponse);
            routes.profile.save(responseBody);

            this.$store.dispatch('dismissAlert', {
              title: '...'
            });
            this.$store.dispatch('alterAuthorized', true)

            Api.rebuild(User.authData());

            /*console.log("User.profile().role: ",User.profile().role);
            User.profile().client.plan_test = 'unsubscribe' ;
            this.$router.push('paymentrequired');*/

            if (User.profile().role == 'superuser') {
              this.$router.push('projects');
            } else {

            if (User.profile().client.plan_test == 'trial') {
              if (User.profile().role == 'clientadmin') {
                var end = Moment(User.profile().client.created_at);
                var now = Moment(new Date());
                var duration = Moment.duration(now.diff(end));
                var days = Math.floor(duration.asDays() - 30);
                this.$store.dispatch('showAlertFail', {
                  title: '"' + Math.abs(days) + '" Number of days remaining in Free Trail',
                  msg: null
                });
              }
            }

            // User.profile().client.creditCardDeactivateDate = "2018-01-17";
            console.log("new Date().getTime() ", new Date().getTime());
            console.log("new Date(User.profile().client.creditCardDeactivateDate).getTime() ", new Date(User.profile().client.creditCardDeactivateDate).getTime());
            console.log("User.profile().role ", User.profile().role);
            // console.log("",);
            if (User.profile().client.plan_test == 'trialExpired' || User.profile().client.plan_test == 'unsubscribe') {
              if (User.profile().role == 'clientadmin') {
                this.$router.push('paymentwarning');
              } else {
                this.$router.push('paymentrequired');
              }
            } else if (User.profile().client.creditCardDeactivateDate != null) {
              console.log("in date check");
              if (new Date().getTime() < new Date(User.profile().client.creditCardDeactivateDate).getTime()) {
                console.log("in date check if");
                if (User.profile().role == 'clientadmin') {
                  var msg = "Oops! Something went wrong! Your Credit Card information needs to be updated for Punchcard. Please update your billing information at your earliest convenience here. Your " + User.profile().client.subdomain +
                    ".punchcardllc.com subscription will expire on " + User.profile().client.creditCardDeactivateDate + "."
                  this.$store.dispatch('showAlertFail', {
                    title: msg,
                    msg: null
                  });
                }
                // if (User.profile().role == 'superadmin') {
                //   this.$router.push('projects');
                // } else {
                  this.$router.push('client');
                // }
              } else {
                if (User.profile().role == 'clientadmin') {
                  this.$router.push('paymentwarning');
                } else {
                  this.$router.push('paymentrequired');
                }
              }
            } else {
              // if (User.profile().role == 'superadmin') {
              //   this.$router.push('projects');
              // } else {
                this.$router.push('client');
              // }
            }
            //window.location.replace(DevConfig.hash + '/projects');
            //this.$router.push('projects');
            }
          }).catch((response) => {
            localStorage.clear();

            let msg;
            if (response.message != null && typeof response.message != 'undefined') {
              msg = response.message;
            } else {
              msg = "" + response;
            }

            this.$store.dispatch('dismissAlert', {
              title: '...'
            });
            this.$store.dispatch('showAlertFail', {
              title: 'Login error',
              msg: response.statusText
            });
          });
        }
      }).catch((response) => {
        let msg;

        if (response.statusText != null && typeof response.statusText != 'undefined') {
          msg = response.status == 401 ? 'Login credentials are incorrect' : response.statusText
        } else {
          msg = "A login error occurred " + response;
        }

        this.$store.dispatch('dismissAlert', {
          title: '...'
        });
        this.$store.dispatch('showAlertFail', {
          title: 'Login error',
          msg: msg
        });
      });
    }
  }
}
</script>
