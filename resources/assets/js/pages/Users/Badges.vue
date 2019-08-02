<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

    }
    ul {
        margin: 0;
        padding: 0;
    }
    li {
        margin: 0;
        list-style-type: none;
    }
</style>
<template>
    <div>
        <h3>Badges</h3>

        <!-- <div v-if="computedProjects">
            <ul>
              <li v-for="project in computedProjects">
                  <badge :project="project" :badge="project.badge"></badge>
              </li>
            </ul>
        </div> -->
        <div v-if="computedProjects" class="row">
            <div v-for="project in computedProjects" class="col-sm-4">
              <badge :project="project" :badge="project.badge"></badge>
            </div>
        </div>
        <div v-else>
            <h4>This user is not staffed on any projects.</h4>
        </div>
    </div>
</template>
<script>
    import Badge from '../../components/Badge.vue';

    export default {
        name: 'user-badges',
        data () {
            return {
                projects: [
                    {
                        name: 'Checking...'
                    },
                    {
                        name: 'Checking...'
                    }
                ],
            }
        },
        created () {
            this.uniq_id = this.$route.params.user_id;

            let routes     = Api.getRoutes('user-admin');
            routes.user.get(this.uniq_id).then((user) => {
                this.user = user;
                this.projects = user.projects;
                this.attachBadges();
            });
        },
        computed: {
            computedProjects: function () {
                if (! this.projects.length) {
                    return
                }

                return this.projects
            }
        },
        props: {
        },
        components: {
            Badge
        },
        methods: {
            attachBadges: function () {
                _.map(this.projects, (proj) => {
                    return this.$store.dispatch('getBadge', [this.uniq_id, proj.uniq_id]).then((badge) => {
                        Vue.set(proj, 'badge', badge);
                    });
                });
            }
        }
    }
</script>
