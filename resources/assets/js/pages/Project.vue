<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    .router-link-active {
        border: 1px solid #aaa;
        border-bottom: 2px solid $body-bg;
    }

    .edit-project {
        float: right;
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
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-sm-2">
                <secure-img :edit_mode="edit_mode" v-if="project.logo"
                    :src="project.logo" className="img-shorten img-rounded img-responsive"
                    title="click to change logo">
                </secure-img>
            </div>
            <div class="col-sm-10">
                <h1>
                    {{ project_name }}
                </h1>
            </div>
        </div>

        <div>

            <ul class="nav nav-tabs">
                <li role="presentation">
                    <router-link :to="{name: 'project-summary', params: { project_id: project_id}}">Summary</router-link>
                </li>
                <li role="presentation">
                    <router-link :to="{name: 'project-users', params: { project_id: project_id}}">Users</router-link>
                </li>
                <li role="presentation">
                    <router-link :to="{name: 'project-virtual-gate', params: { project_id: project_id}}">Virtual Gate</router-link>
                </li>
                <li role="presentation" v-permission="'ProjectsAlter'">
                    <router-link :to="{name: 'project-clients', params: { project_id: project_id}}">Companies</router-link>
                </li>
                <li class="edit-project" v-permission="'ProjectsAlter'">
                    <router-link :to="{name: 'project-edit', params: { project_id: project_id}}">Edit Project</router-link>
                </li>
            </ul>

             <loader style="margin-top: 20px;" :loading="loading"></loader>
             <router-view v-if="!loading"></router-view>

        </div>
    </div>
</template>
<script>
    import SecureImg from '../components/SecureImg.vue';

    export default {
        name: 'project',
        data () {
            return {
                Perm: Perm,
                loading: true,
                project_id: this.$route.params.project_id,
                projects: [],
                project: {
                    name: null
                }
            }
        },
        created () {
            this.$store.dispatch('getProject', this.$route.params.project_id).then((project) => {  // project_id == uniq_id
                this.loading = false;
                this.project = project;
            });
        },
        components: {
            SecureImg
        },
        computed: {
            project_name: function() {
                return this.project.name || 'Loading Project...';
            }
        },
        methods: {
        }
    }
</script>
