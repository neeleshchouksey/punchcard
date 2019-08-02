<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    .router-link-active {
        border: 1px solid #aaa;
        border-bottom: 2px solid $body-bg;
    }

    .nav > li > a:hover, .nav > li > a:focus {
        text-decoration: none;
        background-color: none;
    }

    .nav-tabs {
        border-bottom: 1px solid #ddd;
    }

    @media (max-width: 480px) {
        .nav-tabs > li {
            float:none;
        }
    }
</style>
<template>
    <div>
        <h1>{{ client.name }}</h1>

        <loader :loading="loading"></loader>

        <div v-if="!loading">

            <ul class="nav nav-tabs">
                <li role="presentation">
                    <router-link :to="{name: 'manageuser-employees', params: {uniq_id: uniq_id}}">Employees</router-link>
                </li>
            </ul>

            <router-view></router-view>
        </div>
    </div>
</template>
<script>

    export default {
        name: 'child-main',
        data () {
            return {
                client: {
                    name : User.profileData.client.name
                },
                loading: true,
            }
        },
        created () {

            this.uniq_id = User.profileData.client.uniq_id;

            this.$store.dispatch('getClient', User.profileData.client.uniq_id).then((client) => {
                this.loading = false;
                this.client   = client;
            });
        },
        computed: {
        },
        methods: {
        },
        components: {
        }
    }
</script>
