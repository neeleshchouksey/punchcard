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
        display: flex;
        justify-content: center;
        span {color: $theme-white;}
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
            <span>Thanks for using PunchCard!</span>
        </div>

        <div class="row">
            <button :click="goTologin">Log back in?</button>
        </div>
    </form>
</div>
</template>
<script>
    export default {
        name: 'logout',
        data () {
            return {
                title: "Logout",
                logging_out: true
            }
        },
        created () {
            User.logout();
            this.logging_out = false;
            this.title = "Logged out";
            User.setProfile(null)
            Perm.setRole(null)
            this.$store.dispatch('alterAuthorized', false)
        },
        computed: {
            logoSrc: function ()
            {
                return DevConfig.url + 'images/logo.png'
            },
            homeLink: function()
            {
                return DevConfig.hash + DevConfig.home;
            }
        },
        methods: {
            goToLogin: function() {
                window.location.replace(DevConfig.hash + '/');
            }
        }
    }
</script>
