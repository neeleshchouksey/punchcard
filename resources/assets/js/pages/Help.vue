<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        .help-box {
            h3 {
                margin: 5px 0 20px 0
            }

            border: 1px solid $laravel-border-color;
            border-radius: 5px;
            margin: 25px auto;
            padding: 25px;
        }
    }
</style>
<template>
    <div>
        <h1>Help</h1>
        <div>
            <a href="#nav-trouble">Having navigation trouble?</a>
        </div>

        <hr />

        <div id="nav-trouble" class="help-box">
            <h3>Navigation Trouble</h3>
        </div>

        <div id="client-not-found" class="help-box">
            <h3>Client Not Found</h3>

            <p>
                The client you were trying to load was not found. Please ensure you have access to the client and that
                you are logged in with an appropriate role.
            </p>

            <p>Your role is currently <b>{{ userRole }}</b></p>
        </div>

        <div id="user-not-found" class="help-box">
            <h3>User Not Found</h3>
        </div>

        <div id="project-not-found" class="help-box">
            <h3>Project Not Found</h3>
        </div>

        <div style="height: 800px;"></div>
    </div>
</template>
<script>
    //import User from '../api/user'

    export default {
        name: 'help',
        data () {
            return {
                User: User
            }
        },
        created () {
        },
        computed: {
            userRole: function () {
                return this.User.auth()
            }
        },
        methods: {
        }
    }
</script>
