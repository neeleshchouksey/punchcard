<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        .navbar {
            background-color: $theme-gold;
            ul, li, a {
                height: 60px;
                color: $theme-slate;
                line-height: 35px;
            }
            span {
                color: $theme-slate;
                font-weight: 700;
            }
            img {

            }
        }
        .container-fluid {
            padding-left: 0;
        }
        .navbar-header {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 60px;
            color: $theme-white;
            font-size: 3rem;
            span, a, img {
              margin-left: 15px;
            }
            img {
                margin-top: 5px;
            }
        }
    }
</style>
<template>
    <div>
        <nav class="navbar navbar-inverse navbar-fixed-top" v-if="authorized">
          <div class="container-fluid">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <span>Punchcard</span>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav navbar-right">
                <!-- v-permission="'ProfileAlter'" -->
                <li  v-if="canViewSideNav"><router-link  class='nav-title' to="/profile">Profile</router-link></li>
                <li><router-link  class='nav-title' to="/logout">Logout</router-link></li>
              </ul>
            </div>
          </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-2 sidebar" v-if="authorized && canViewSideNav">
                    <sidebar> </sidebar>
                </div>

                <div class="col-sm-10 col-sm-offset-2 main">

                    <app-alert></app-alert>

                    <router-view>
                        <Home></Home>
                    </router-view>

                </div>
            </div>
        </div>
    </div>
</template>
<script>
    //import User from '../api/user'

    export default {
        name: 'app',
        data () {
            return {
                User: User, // to make reactive
            }
        },
        created () {
            this.Perm = Perm;
        },
        props: {
            defaultAuth: {
                type: Boolean,
                default: false
            }
        },
        computed: {
            authorized: function ()
            {
                return this.$store.state.users.Authorized
            },
            canViewSideNav: function ()
            {
              console.log(User.profile().client.plan_test);
              console.log("User.profile().client.creditCardDeactivateDate: ",User.profile().client.creditCardDeactivateDate);

              if (User.profile().role == 'superuser') {
                return true;
              } else {
                if(User.profile().client.plan_test == 'trialExpired' || User.profile().client.plan_test == 'unsubscribe'){
                  this.$router.push('paymentwarning');
                  return false;
                } else if(User.profile().client.creditCardDeactivateDate!=null){
                  if (new Date().getTime() > new Date(User.profile().client.creditCardDeactivateDate).getTime()) {
                    this.$router.push('paymentwarning');
                    return false;
                  }
                }
                return true;
              }
            },
        },
        components: {
        },
        methods: {
        }
    }
</script>
