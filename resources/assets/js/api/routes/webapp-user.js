let apiPromise = require('../api-promise.js').default;
var Config = require('../../config.js').default;

export default {

    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    timesheets: {
        put: (data) => {
            let endpoint = '/webapp/users/' + data.uniq_id + '/timesheets';
            return this.caller.put(endpoint, data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        }
    },


    avatar: {
        put: (data) => {
            return this.caller.put('/webapp/user-avatar', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },

    profile: {
        get: (uniq_id = null, refresh = false) => {
            let endpoint;

            if (! uniq_id) {
                uniq_id = 'profile'
                endpoint = '/webapp/user/'
            } else {
                endpoint = '/webapp/user/' + uniq_id;
            }

            return new apiPromise(this.caller, endpoint, uniq_id);
        },

        save: function (userProfile)
        {
            User.setProfile(userProfile)
        }
    },

    login: {
        post: (username, password) => {
            let data = {
                "grant_type": "password",
                "client_id": Config.client_id,
                "client_secret": Config.client_secret,
                "username": username,
                "password": password,
                "scope": ""
            }

            return Api.post('/oauth/token', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },

        save: function (responseBody)
        {
            localStorage.setItem('auth', JSON.stringify(responseBody));
        },

        update: function (authUpdate)
        {
            Api.update('auth', authUpdate);
        }
    }
}
