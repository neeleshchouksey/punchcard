<style lang="sass" scoped>
    @import '../../../../sass/_variables.scss';
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
                    <router-link :to="{name: 'child-summary', params: {uniq_id: uniq_id}}">Company Information</router-link>
                </li>

                <!-- <li role="presentation">
                    <router-link :to="{name: 'child-projects', params: {uniq_id: uniq_id}}">Projects</router-link>
                </li> -->

                <li role="presentation">
                    <router-link :to="{name: 'child-employees', params: {uniq_id: uniq_id}}">Employees</router-link>
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
                    uniq_id: null,
                    logo: null
                },
                loading: true,
            }
        },
        created () {
            if (this.$route.params.uniq_id !== null) {
                this.uniq_id = this.$route.params.uniq_id;
            }

            this.$store.dispatch('getClient', this.uniq_id).then((client) => {
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
