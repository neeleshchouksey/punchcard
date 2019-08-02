<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        .value-clear {
            position: absolute;
            right: 5px;
            top: 0;
            bottom: 0;
            height: 14px;
            margin: auto;
            font-size: 14px;
            cursor: pointer;
            color: #ccc;
        }
    }
</style>
<template>
    <form action="#" name="form-login" id="form-login">
        <h1>Login to Punchcard</h1>
        <div class="row">
            <label>
                Username:
                <div class="btn-group">
                    <input v-model="username" ref="username" type="text" placeholder="Enter username, email or mobilenumber" />
                    <span @click="valueClear('username')" class="value-clear glyphicon glyphicon-remove-circle"></span>
                </div>
            </label>

            <label>
                Password:
                <div class="btn-group">
                    <input v-model="pwd" ref="pwd" type="password" placeholder="Enter password" />
                    <span @click="valueClear('pwd')" class="value-clear glyphicon glyphicon-remove-circle"></span>
                </div>
            </label>
        </div>
        <div class="row">
            <label>
                Subdomain:
                <div class="input-group">
                    <span class="input-group-addon">http://</span>
                    <input v-model="subdomain" type="text" placeholder="Enter the subdomain" style="border-radius: 0;" />
                    <span @click="valueClear('pwd')" class="value-clear glyphicon glyphicon-remove-circle"></span>
                    <span class="input-group-addon" id="basic-addon2">.example.com</span>
                </div>
            </label>
        </div>

        <div class="row">
            <input @click.prevent="doLogin" type="submit" value="Login" class="primary-button btn" />
        </div>

        <div>
            Forgot Password? <a href="http://www.punchcardllc.com/password/reset/">Click here for password reset</a>
        </div>
    </form>

</template>
<script>
    //import User from '../api/user'

    export default {
        name: 'login',
        data () {
            return {
                username: 'AllisonStiedemann',
                subdomain: 'kunde-tremblay8254',
                pwd: 'abc123456'
            }
        },
        created () {
            //
            // If logged in, redirect to projects page for landing
            //
            if (User.auth()) {
                window.location.replace('/projects');
            }
        },
        components: {
        },
        methods: {
            valueClear: function (whichRef) {
                this.$refs[whichRef].value = '';
            },
            doLogin: function () {

                let subdomain  = this.subdomain.replace(/[^-_0-9a-zA-Z]/, '');
                let routes     = Api.getRoutes('webapp-user');

                Api.rebuild(this.username, this.pwd, subdomain);
                this.$store.dispatch('showAlertInfo', {title: 'Logging in...'});
                routes.profile.get().then((user) => {
                    if (user) {
                        this.$store.dispatch('showAlertInfo', {title: 'Logged in...'});
                        routes.profile.save(this.username, this.pwd, subdomain, user);
                        this.$emit('auth-change', true);

                        this.$store.dispatch('dismissAlert', {title: '...'});
                        window.location.replace('/projects');
                    }
                }).catch((response) => {
                    let msg;
                    if (response.data.message != null && typeof response.data.message != 'undefined') {
                        msg = response.data.message;
                    } else {
                        msg = "" + response.data;
                    }

                    this.$store.dispatch('dismissAlert', {title: '...'});
                    this.$store.dispatch('showAlertFail', {title: 'Login error', msg: msg});
                });
            }
        }
    }
</script>
