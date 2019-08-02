<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';

      .content-box{
        height: 200px;
        margin: 10px;


      }
        .content-section{
              height: 100%;

          color: $list-element-major-font-color;
          background-color: $list-element-major-bg;
          border: 1px solid transparent;
          border-color: $list-element-major-border;
          border-radius: $general-border-radius;
        }
        .content-section:hover {
            background-color: $list-element-major-hover-bg;
            border-color: $list-element-major-hover-border;
        }
          .image img {
            width: -webkit-fill-available !important;
            height: -webkit-fill-available !important;
            }
          .project-image {
            width: -webkit-fill-available !important;
            height: -webkit-fill-available !important;
            }

          .details-text{
            font-size: 17px;
            margin: 6px 0px 0px 0px;
          }

</style>
<template>
    <div>
        <h3>Projects</h3>

        <!-- <div v-if="computedProjects">
            <ul class='projects'>
              <li v-for="project in computedProjects">
                <router-link :to="{ path: '/project/' + project.uniq_id + '/summary'}">
                    <project-list :onSite="false" :project="project"></project-list>
                </router-link>
              </li>
            </ul>
        </div> -->
        <div class="col-sm-6 " v-if="computedProjects" v-for="project in computedProjects">
          <div class="content-box">
            <div class="row content-section">
              <router-link v-if="project.uniq_id" :to="{ path: '/project/' + project.uniq_id + '/summary', meta: { project_name: project.name }}">
                <project-list :onSite="true" :project="project"></project-list>
              </router-link>
            </div>
          </div>
        </div>
        <div v-else>
            <h4>This user is not staffed on any projects.</h4>
        </div>
    </div>
</template>
<script>
    //import User from '../../api/user';
    import ProjectList from '../Projects/List.vue';
    let projectsHelper = require ('../../helpers/projects.js').default;

    export default {
        name: 'user-projects',
        data () {
            return {
                searchSelectedValueReactive: 'All Projects',
                projects: [
                    {
                        name: 'Checking...'
                    },
                ],
                searchFilter: null
            }
        },
        created () {
            this.uniq_id = this.$route.params.user_id;

            let routes     = Api.getRoutes('user-admin');
            routes.user.get(this.uniq_id).then((user) => {
                this.user = user
                this.projects = user.projects
            });
        },
        computed: {
            searchSelectedValue: function () {
                return this.searchSelectedValueReactive;
            },
            computedProjects: function () {

                if (! this.projects.length) {
                    return;
                }

                return this.projects;

            }
        },
        methods: {
        },
        components: {
            ProjectList
        }
    }
</script>
<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
        button.btn-spaced {
            margin-top: 5px ;
            margin-bottom: 5px ;
        }
</style>
