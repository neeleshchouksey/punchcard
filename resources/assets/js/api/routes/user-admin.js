let apiPromise = require('../api-promise.js').default;

export default {

    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    timesheets: {
        get: (user_uniq_id, refresh = true) => {
            let endpoint = '/webapp/users/' + user_uniq_id + '/timesheets';
            let key = btoa(endpoint);
            return new apiPromise(this.caller, endpoint, key, refresh);
        }
    },

    user: {
        get: (user_uniq_id, refresh = false) => {
            let endpoint = '/webapp/users/' + user_uniq_id;
            return new apiPromise(this.caller, endpoint, user_uniq_id, refresh);
        },
    },
}
