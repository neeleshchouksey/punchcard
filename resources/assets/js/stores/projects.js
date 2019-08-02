import store from './index';
import {router} from '../routes.js'

const state = {
    projects: [],
    project: {},
    //projectQueue: {}
}

//
// Think of getters as computed properties for stores
//
const getters = {
    project: (state, getters) => {
        //return state.projects.filter(project);
    }
}

const mutations = {
    GET_PROJECTS(state, projects) {
        state.projects = projects
    },
    GET_PROJECT(state, project) {
        state.project = project
    },
    // SAVE_PROJECT_TO_QUEUE(state, project) {
    //     state.projectQueue[project.uniq_id] = project;
    // },
    UPDATE_PROJECT(state, project) {
    },
    DELETE_PROJECT(state, project) {
    },
}

const actions = {
    toggleScannerAccess: ({commit}, args) => {

            let user  = args[0];
          let project = args[1];

        if (typeof user.permissions.scanner == 'undefined' || user.permissions.scanner == null) {
            user.permissions['scanner'] = [];
        }

        let removeAt = _.indexOf(user.permissions.scanner, project.id);

        if(removeAt > -1) {
            // found, remove it
            user.permissions.scanner.splice(removeAt, 1);

        } else {
            // not found, add it
            user.permissions.scanner.push(project.id);
        }

        //
        // Save on the server
        //
        let data = {
            'user_uniq_id': user.uniq_id,
            'project_uniq_id': project.uniq_id,
            'data': user.permissions.scanner
        };


        let routes = Api.getRoutes('webapp-check');
        return routes.toggle.post(data).then((response) => {
            return {"user": user, "response": response}
        });
    },



    getProjects: ({commit}, uniq_id = null) => {
        let routes     = Api.getRoutes('webapp-projects');

        return routes.projects.get().then((projects) => {
            commit('GET_PROJECTS', projects);
            return projects;
        });
    },

    getProjectEmployeeOnSite: ({commit}, uniq_id = null) => {
        let data = {
          project_id : uniq_id,
          client_id : User.profileData.client_id
        };
        let routes     = Api.getRoutes('webapp-projects');

        return routes.getProjectEmployeeOnSite.post(data).then((employees) => {
            return employees;
        });
    },
    getProjectCompanyOnSite: ({commit}, uniq_id = null) => {
        let data = {
          project_id : uniq_id,
          client_id : User.profileData.client_id
        };
        let routes     = Api.getRoutes('webapp-projects');

        return routes.getProjectCompanyOnSite.post(data).then((company) => {
            return company;
        });
    },

    getProject: ({commit}, uniq_id) => {

        let project;

        // if (typeof state.projectQueue[uniq_id] != 'undefined' &&
        //     state.projectQueue[uniq_id] != null &&
        //     state.projectQueue[uniq_id] != 'undefined' &&
        //     state.projectQueue[uniq_id] != undefined) {
        //
        //         project = state.projectQueue[uniq_id];
        //         commit('GET_PROJECT', project);
        //
        // } else {
            let routes     = Api.getRoutes('webapp-projects');

            project = routes.projects.get(uniq_id).then((project) => {

                // let project = _.filter(projects, function(p) {
                //     return p.uniq_id == uniq_id;
                // }.bind(this));

                //
                // NOTE:
                //
                // TO BE REACTIVE, THIS HAS TO BE INITIALIZED HERE, if it is not already defined by here
                // Once in the component.vue, you can't make it reactive anymore, even if you copy
                // to a local state variable!
                // project[0].totalDays = 199;
                //
                // project.totalDays       = 199;
                // project.totalHours      = 169;
                // project.employeesOnsite = 179;
                // project.companiesOnsite = 189;

                //commit('SAVE_PROJECT_TO_QUEUE', project);
                commit('GET_PROJECT', project);
                return project;
            }).catch((response) => {
                let msg;
                if (response.data.message != null && typeof response.data.message != 'undefined') {
                    msg = response.data.message;
                } else {
                    msg = "" + response.data;
                }

                commit('GET_PROJECT', {});

                store.dispatch('showAlertFail', {title: 'Retrieval error', msg: msg});
            });
//        }

        return project;
    }
}

export default {
    state, getters, mutations, actions
}
