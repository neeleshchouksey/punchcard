let apiPromise = require('../api-promise.js').default;

export default {

    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    client: {
        get: (uniq_id, refresh = true) => {
            let endpoint = '/webapp/clients/';

            if (uniq_id !== null) {
                endpoint += uniq_id;
            }

            let key = uniq_id ? uniq_id : 'client';

            return new apiPromise(this.caller, endpoint, key, refresh);
        },
        del: (data) => {
            let endpoint = '/webapp/clients';
            return this.caller.del(endpoint, data)
        },
    },
    logo: {
        put: (data) => {
            return this.caller.put('/webapp/client-logo', data).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },
}
