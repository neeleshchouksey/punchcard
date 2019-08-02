import store from './index';
import {router} from '../routes.js'

const state = {
    reportOptions: {},
    reportData: {},
}

const mutations = {
    SET_REPORT_OPTIONS(state, options) {
        state.reportOptions = options
    },
    GET_REPORTS_OPTION_DATA(state, option_data) {
        state.reportData = option_data
    },
}

const actions = {
    setReportOptions: ({commit}, options) => {
        commit('SET_REPORT_OPTIONS', options);
    },

    getReportOptionData: ({commit}, uniq_id = null) => {
        let routes     = Api.getRoutes('webapp-reports');

        return routes.report_option_data.get(uniq_id).then((option_data) => {
          console.log("option_data.reportOptionData******************", option_data.reportOptionData);
            commit('GET_REPORTS_OPTION_DATA', option_data.reportOptionData);
            //return option_data;
        });
    },
}

export default {
    state, mutations, actions
}
