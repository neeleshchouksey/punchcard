import store from './index';
import {router} from '../routes.js'

const state = {
    reports: [],
    all_reports: [],
    reportData: {},
    exportableReportData: {},
    formData: {},
    report: {},
}

//
// Think of getters as computed properties for stores
//
const getters = {
    report: (state, getters) => {
    }
}

const mutations = {
    PASS_SUB_REPORT_DATA(state, reportData) {
        state.reportData = reportData;
    },

    SET_EXPORTABLE_REPORT_DATA(state, exportData) {
        state.exportableReportData = exportData;
    },

    GET_REPORTS(state, reports) {
        state.reports = reports
    },
    GET_ALL_REPORTS(state, reports) {
        state.all_reports = reports
    },
    GET_REPORT(state, report) {
        state.report = report
    },
    UPDATE_REPORT(state, report) {
    },
    DELETE_REPORT(state, report) {
    },
}

const actions = {
    toggleReportAccess: ({commit}, args) => {

            let user = args[0];
          let report = args[1];

        if (typeof user.permissions.reports == 'undefined' || user.permissions.reports == null) {
            user.permissions['reports'] = [];
        }

        let removeAt = _.indexOf(user.permissions.reports, report.id);

        if(removeAt > -1) {
            // found, remove it
            user.permissions.reports.splice(removeAt, 1);

        } else {
            // not found, add it
            user.permissions.reports.push(report.id);
        }

        //
        // Save on the server
        //
        let data = {
            'user_uniq_id': user.uniq_id,
            'report_uniq_id': report.uniq_id,
            'data': user.permissions.reports
        };

        let routes = Api.getRoutes('webapp-reports');
        return routes.toggle.post(data).then((response) => {
            return {"user": user, "response": response}
        });
    },

    getReportData: ({commit}, uniq_id = null) => {
        let routes     = Api.getRoutes('webapp-reports');

        // return routes. FIX report_option_data.get(uniq_id).then((option_data) => {
        //     return option_data;
        // });
    },

    getAllReports: ({commit}) => {
        let routes     = Api.getRoutes('webapp-reports');

        //return routes.allreports.get().then((reports) => {
        return routes.reports.get().then((reports) => {
            commit('GET_ALL_REPORTS', reports);
            return reports;
        });
    },

    getReports: ({commit}, uniq_id = null) => {
        let routes     = Api.getRoutes('webapp-reports');

        return routes.reports.get().then((reports) => {
            commit('GET_REPORTS', reports);
            return reports;
        });
    },

    getReport: ({commit}, uniq_id) => {

        let report;

        let routes     = Api.getRoutes('webapp-reports');

        report = routes.reports.get(uniq_id).then((report) => {

            if (! report) {
                return null;
            }

            commit('GET_REPORT', report)
            return report;
        }).catch((response) => {
            let msg;
            if (typeof response.data.message != 'undefined' && response.data.message != null) {
                msg = response.data.message;
            } else {
                msg = "" + response.data;
            }

            store.dispatch('showAlertFail', {title: 'Retrieval error', msg: msg});
        });

        return report;
    },

    clearReportData: ({commit}) => {
        commit('PASS_SUB_REPORT_DATA', {})
    },

    setExportableReportData: ({commit}, exportableData) => {
        commit('SET_EXPORTABLE_REPORT_DATA', exportableData)
    },

    passSubReportData: ({commit}, httpReportData) => {

        if (typeof httpReportData.required === 'undefined') {
            console.error('You must pass in what report data is required');
            return
        }

        //
        // Before we hit the server, let's make sure we have all the
        // required data and bail if we don't
        //
        if (httpReportData.required !== null) { // if not 'undefined' but null, it's a report that needs no data
            for (let i=0; i < httpReportData.required.length; i++) {
                let field = httpReportData.required[i];
                if (typeof httpReportData[field] === 'undefined' || httpReportData[field] === null) {
                    return;
                }
            }
        }

        let reportData;
        let uniq_id = httpReportData.report_uniq_id;
        let routes  = Api.getRoutes('webapp-reports');

        reportData = routes.report_data.get(uniq_id, httpReportData).then((reportData) => {

            if (! reportData) {
                return null;
            }

            reportData.formData = httpReportData;

            commit('PASS_SUB_REPORT_DATA', reportData);
            store.dispatch('loading', false);
            return reportData;
        }).catch((response) => {
            let msg;
            if (typeof response.data.message != 'undefined' && response.data.message != null) {
                msg = response.data.message;
            } else {
                msg = "" + response.data;
            }

            store.dispatch('showAlertFail', {title: 'Retrieval error', msg: msg});
        });

        return reportData;
    }
}

export default {
    state, getters, mutations, actions
}
