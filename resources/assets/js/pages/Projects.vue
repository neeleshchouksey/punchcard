<style lang="sass" scoped>
    @import '../../sass/_variables.scss';

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
<div v-permission="'ProjectsView'">
  <div>
    <div class="major-section-header-row">
      <h2>Projects
                    <span style="font-size: 70%" v-if="loading">(Loading ...)</span>
                </h2>
      <router-link :to="{ path: '/project-new/'}" v-permission="'ProjectsAlter'">
        <button type="button" class="btn-spaced material btn btn-default" id='add-project'>Add Project</button>
      </router-link>
    </div>
    <hr>

    <div v-if="computedProjects">
      <div class="input-group">
        <input type="text" class="form-control" aria-label="search" placeholder="Search for..." name="searchTerm" v-model="searchFilter">
        <div class="input-group-btn">
          <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span>{{ searchSelectedValue }}</span> <span class="caret"></span>
                        </button>

          <input type="hidden" v-model="searchSelectedValue" />
          <ul class="dropdown-menu dropdown-menu-left dd-filter">
            <li @click="setSearchSelectedValue">All Projects</li>
            <li @click="setSearchSelectedValue">Active</li>
            <li @click="setSearchSelectedValue">Inactive</li>
          </ul>
        </div>
      </div>

      <!-- <ul class="projects">
        <li v-for="project in computedProjects">
          <router-link :to="{ path: '/project/' + project.uniq_id + '/summary', meta: { project_name: project.name }}">
            <project-list :onSite="true" :project="project"></project-list>
          </router-link>
        </li>
      </ul> -->

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
    <div v-else>
      <h3>No projects yet available.</h3>

    </div>
  </div>
</div>
</template>
<script>
import ProjectList from './Projects/List.vue';
let projectsHelper = require('../helpers/projects.js').default;

export default {
  name: 'projects',
  data() {
    return {
      Perm: Perm,
      searchSelectedValueReactive: 'active',
      loading: true,
      projects: [{
        title: '',
        onSite: '0',
        logo: null,
      },{
        title: '',
        onSite: '0',
        logo: null,
      },{
        title: '',
        onSite: '0',
        logo: null,
      },{
        title: '',
        onSite: '0',
        logo: null,
      }, ],
      searchFilter: null
    }
  },
  created() {
    this.$store.dispatch('getProjects').then((projects) => {
      this.loading = false;
      this.projects = projects;
    });
  },
  computed: {
    searchSelectedValue: function() {
      return this.searchSelectedValueReactive;
    },
    computedProjects: function() {

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
  },
  components: {
    ProjectList
  }
}
</script>
<style lang="sass" scoped>
    @import '../../sass/_variables.scss';

    button.btn-spaced {
        margin-top: 5px ;
        margin-bottom: 5px ;
    }

    ul.dd-filter {
        li {
            margin: 10px;
            padding: 0;
            list-style-type: none;
        }
    }
</style>
