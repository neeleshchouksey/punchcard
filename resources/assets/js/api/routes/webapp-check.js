let apiPromise = require('../api-promise.js').default;

export default {

    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    toggle: {
        post: (data) => {
            let endpoint = '/webapp/check/scanner/toggle/'
            return this.caller.post(endpoint, data)
        }
    },

    punch: {
        post: (data) => {
            let endpoint = '/webapp/check/badge/'
            return this.caller.post(endpoint, data)
        },
        put: (data) => {
            let endpoint = '/webapp/check/badge/'
            return this.caller.put(endpoint, data)
        }
    },
}
