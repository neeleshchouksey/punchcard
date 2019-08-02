<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div>
        <loader :loading="loading" loading_msg="Loading Users..."></loader>

        <div v-show="!loading">
            <h3>Reset Password</h3>

            <div v-if="currentUserIsViewing">
                <p>Enter your current password below and we'll send a password reset link to your email</p>

                <api-form action="/user/password" method="PUT" id="user-password-reset"
                    v-on:form-complete="formCompleteSelf"
                    v-model="userPasswordReset">
                    <input v-model="userPasswordReset.current_password" type="password" placeholder="enter your current password" />
                    <input v-model="userPasswordReset.new_password" type="password" placeholder="enter a new password" />
                    <input v-model="userPasswordReset.new_password_confirmation" type="password" placeholder="repeat the new password" />
                    <input class="primary-button btn" type="submit" value="Reset" />
                </api-form>
            </div>

            <div v-else>
                <p>Click the buttom below and a password reset email will be sent to the user at the email address we
                have on record for them.</p>

                <api-form action="web:/password/email" method="REALPOST" id="webapp-password-reset"
                    v-on:form-complete="formCompleteOther"
                    v-if="userJustEmail.email" v-model="userJustEmail">
                    <input type="hidden" v-model="user.email" />
                    <input type="hidden" v-model="_token" />
                    <input class="primary-button btn" type="submit" value="Send Reset Email to this user" />
                </api-form>
            </div>
        </div>
    </div>
</template>
<script>
    import ApiForm from '../../components/ApiForm.vue'
//    import User from '../../api/user';

    export default {
        name: 'user-password-reset',
        data () {
            return {
                loading: true,
                _token: null,
                user: {
                    email: null
                },
                userJustEmail: {
                    email: null
                },
                userPasswordReset: {
                    current_password: null,
                    new_password: null,
                    new_password_confirmation: null,
                }
            }
        },
        created () {
            this.loading = false;
            this.uniq_id = this.$route.params.user_id;

            let routes     = Api.getRoutes('user-admin');
            routes.user.get(this.uniq_id).then((user) => {
                this.user = user
                this.userJustEmail.email = user.email
                this.loading = false
            });
        },
        props: {
            renameMe: {
                type: String,
                default: null
            },
        },
        computed: {
            currentUserIsViewing: function () {
                return this.uniq_id == User.profile().uniq_id;
            }
        },
        components: {
            ApiForm,
        },
        methods: {
            formCompleteSelf: function(data, response)
            {
                if (response.status == 200) {
                    this.$store.dispatch('showAlertSuccess', {'title': 'Password changed', 'msg': null})
                    window.history.back();
                }
            },
            formCompleteOther: function(data, response)
            {
              try {
                response = JSON.parse(response);
                this.$store.dispatch('showAlertSuccess', {'title': 'Error', 'msg': response.message})
              } catch (e) {
                this.$store.dispatch('showAlertSuccess', {'title': 'Reset Email Sent', 'msg': null});
              }
              window.history.back();
            }
        }
    }
</script>
