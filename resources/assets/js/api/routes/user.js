let apiPromise = require('../api-promise.js').default;

export default {

    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    badge: {
        get: (user_uniq_id, project_uniq_id, refresh = false) => {
            let endpoint = '/user/badge/' + user_uniq_id + '/' + project_uniq_id;
            let key = btoa(endpoint);
            return new apiPromise(this.caller, endpoint, key, refresh);
        }
    }
}
