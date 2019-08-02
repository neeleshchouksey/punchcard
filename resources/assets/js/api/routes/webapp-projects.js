let apiPromise = require('../api-promise.js').default;

export default {

    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    logo: {
        put: (data) => {
            return this.caller.put('/webapp/project-logo', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },

    project_users: {
        staffed: (uniq_id = null, refresh = false) => {
            return new apiPromise(this.caller, '/webapp/project-users/' + uniq_id + '/staffed', 'project-users-' + uniq_id, refresh);
        },

        get: (uniq_id = null, refresh = true) => {
            return new apiPromise(this.caller, '/webapp/project-users/' + uniq_id, 'project-users-' + uniq_id, refresh);
        },

        put: (data) => {
            return this.caller.put('/webapp/project-users', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },

        post: (data) => {
            return this.caller.post('/webapp/project-users', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },

    project_clients: {
        get: (uniq_id = null, refresh = true) => {
            return new apiPromise(this.caller, '/webapp/project-clients/' + uniq_id, 'project-clients-' + uniq_id, refresh);
        },

        put: (data) => {
            return this.caller.put('/webapp/project-clients/', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },

        post: (data) => {
            return this.caller.post('/webapp/project-clients/', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },

    project_child_user: {
        post: (data) => {
            return this.caller.post('/webapp/addAllChildUsers', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },


    projects: {
        get: (uniq_id = null, refresh = false) => {
            let endpoint;

            if (! uniq_id) {
                uniq_id = 'projects'
                endpoint = '/webapp/projects'
            } else {
                endpoint = '/webapp/projects/' + uniq_id;
            }

            return new apiPromise(this.caller, endpoint, uniq_id, refresh);
        },
    },

    getProjectEmployeeOnSite: {
      post: (data) => {
          console.log('/webapp/employeesCurrentlyOnSite', data);
          return this.caller.post('/webapp/employeesCurrentlyOnSite', data).then((response) => {
              return response;
          }).catch((response) => {
              return Promise.reject(response);
          });
      }
    },
    getProjectCompanyOnSite: {
      post: (data) => {
          console.log('/webapp/getProjectCompanyOnSite', data);
          return this.caller.post('/webapp/companiesCurrentlyOnSite', data).then((response) => {
              return response;
          }).catch((response) => {
              return Promise.reject(response);
          });
      }
    },
}
