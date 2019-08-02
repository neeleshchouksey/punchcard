<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    .router-link-active {
        border: 1px solid #aaa;
        border-bottom: 2px solid $body-bg;
    }

    .delete-user {
        float: right;
    }

    .nav-tabs {
        border-bottom: 1px solid #ddd;
    }

    @media (max-width: 480px) {
        .router-link-active {
            border: 0;
            border-bottom: 0;
        }

        .nav-tabs {
            font-size: 125%;
            border-bottom: 0;
        }

        .nav-tabs > li {
            float:none;
        }
    }
</style>
<template>
    <div>
        <h1>{{ user.name }}</h1>

        <loader :loading="loading"></loader>

        <div v-show="!loading">


        <ul class="nav nav-tabs">
            <li role="presentation">
                <router-link :to="{name: 'user-details', params: { user_id: user_id}}">Details</router-link>
            </li>
            <li role="presentation">
                <router-link :to="{name: 'user-projects', params: { user_id: user_id}}">Projects</router-link>
            </li>
            <li role="presentation">
                <router-link :to="{name: 'user-badges', params: { user_id: user_id}}">Badges</router-link>
            </li>
            <li role="presentation">
                <router-link :to="{name: 'user-timesheets', params: { user_id: user_id}}">Timesheets</router-link>
            </li>
            <li role="presentation">
                <router-link :to="{name: 'user-reports', params: { user_id: user_id}}">Reports List</router-link>
            </li>
            <li class="float: right">
                <router-link :to="{name: 'user-delete', params: { user_id: user_id}}">Delete Employee</router-link>
            </li>
        </ul>

         <router-view></router-view>

        </div>
    </div>
</template>
<script>
    export default {
        name: 'user-main',
        data () {
            return {
                loading: true,
                user: { name: null },
                user_id: this.$route.params.user_id
            }
        },
        created () {
            this.uniq_id = this.$route.params.user_id;

            let routes     = Api.getRoutes('user-admin');
            routes.user.get(this.uniq_id).then((user) => {
                this.user = user;
                this.projects = user.projects;
                this.loading = false;
            }).catch(response => {
            });
        },
        computed: {
        },
        methods: {
        }
    }
</script>
