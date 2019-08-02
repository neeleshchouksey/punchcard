<style lang="sass" scoped>
    @import '../../../../sass/_variables.scss';
    .content-box{
      height: 240px;
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
        <loader :loading="loading" loading_msg="Loading Projects..."></loader>

        <div v-show="!loading">

            <router-link :to="{name: 'child-user-add', params: {uniq_id: uniq_id}}">
                <button class="btn btn-primary" aria-expanded="false">
                    Add Project
                </button>
            </router-link>

            <div v-if="projectFound">

                <div class="input-group">
                    <input type="text" class="form-control" aria-label="search" placeholder="Search for..."
                        name="searchTerm" v-model="searchFilter">
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-default dropdown-toggle"
                            style="width: 150px"
                            data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false">
                                {{ searchSelectedValue }} <span class="caret"></span>
                        </button>

                        <input type="hidden" v-model="searchSelectedValue" />
                        <ul class="dropdown-menu dropdown-menu-left dd-filter">
                          <li @click="setSearchSelectedValue">All Projects</li>
                          <li @click="setSearchSelectedValue">Active</li>
                          <li @click="setSearchSelectedValue">Inactive</li>
                        </ul>
                    </div>
                </div>

                <div v-show="!loading" class="row">
                  <div class="col-sm-6 " v-for="project in computedProjects">
                    <div class="content-box">
                      <div class="row content-section">
                        <router-link v-if="project.uniq_id" :to="{ path: '/project/' + project.uniq_id + '/summary', meta: { project_name: project.name }}">
                          <project-list :onSite="true" :project="project"></project-list>
                        </router-link>
                      </div>
                    </div>
                  </div>
                </div>
             </div>

             <div v-else>
                <div><h3>No Projects found</h3></div>
             </div>
        </div>
    </div>
</template>
<script>
import ProjectList from '../../Projects/List.vue';
let projectsHelper = require('../../../helpers/projects.js').default;
    export default {
        name: 'child-employees',
        data () {
            return {
                loading: true,
                searchSelectedValueReactive: 'active',
                projects: [],
                searchFilter: null
            }
        },
        components: {
          ProjectList
        },
        created () {
          console.log('on project create')
            this.uniq_id = this.$route.params.uniq_id;

            let routes     = Api.getRoutes('webapp-client');

            routes.client.get(this.uniq_id).then((client) => {
                this.client  = client;
                this.projects   = client.projects;
                this.loading = false;
            });
        },
        computed: {
            searchSelectedValue: function () {
                return this.searchSelectedValueReactive;
            },
            projectFound: function () {
                return this.projects.length;
            },
            computedProjects: function () {

                if (!this.projects.length) {
                  return;
                }

                let filteredProjects = projectsHelper.formatDates(this.projects);

                let found = _.filter(filteredProjects, function(o) {
                  return this.isStatus(o.status) && this.isMatch(o);
                }.bind(this));

                return _.orderBy(found, 'name');
            }
        },
        methods: {
            isMatch(o) {
              if (this.searchFilter === null) {
                return true;
              }

              let all = o.name + ' ' + o.description + ' ' + o.startDateFormatted + ' ' + o.endDateFormatted;
              return all.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
            },
            isStatus(status) {
              let activeStatus = this.searchSelectedValue.toLowerCase();
              if (activeStatus != 'active' && activeStatus != 'inactive') {
                return true; // All
              }

              return activeStatus == status;
            },
            setSearchSelectedValue: function(val) {
              this.searchSelectedValueReactive = val.srcElement.innerText;
            }
        }
    }
</script>
