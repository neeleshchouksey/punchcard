let apiPromise = require('../api-promise.js').default;

export default {

    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    toggle: {
        post: (data) => {
            let endpoint = '/webapp/reports/toggle/'
            return this.caller.post(endpoint, data)
        }
    },

    allreports: {
        get: (refresh = false) => {
            return new apiPromise(this.caller, '/webapp/allreports', 'allreports', refresh);
        },
    },

    report_data: {
        get: (uniq_id, data,  refresh = true) => { // sic - want fresh data each load; server can cache
            data.required = null
            return Api.get('/webapp/reporting/' + uniq_id, data).then((response) => {
                return response.body.data;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },

    report_option_data: {
        get: (uniq_id) => {
            return new apiPromise(this.caller, '/webapp/reporting/option-data/' + uniq_id, 'report_option_data');
        },
    },

    export: {
        csv: (data) => {
            return Api.post('/webapp/data-exports/csv', data, {responseType: 'arraybuffer'}).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
        pdf: (data) => {
            return Api.post('/webapp/data-exports/pdf', data, {responseType: 'arraybuffer'}).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
        excel: (data) => {
            return Api.post('/webapp/data-exports/excel', data, {responseType: 'arraybuffer'}).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
        bulk: () => {
            let data = {};
            return Api.get('/webapp/data-exports/bulk', data, {responseType: 'arraybuffer'}).then((response) => {
                return response;
            }).catch((response) => {
                return Promise.reject(response);
            });
        },
    },

    reports: {
        get: (uniq_id = null, refresh = false) => {
            let endpoint;

            if (! uniq_id) {
                uniq_id = 'reports'
                endpoint = '/webapp/reports'
            } else {
                endpoint = '/webapp/reports/' + uniq_id;
            }

            return new apiPromise(this.caller, endpoint, uniq_id, refresh);
        },
    },
}
