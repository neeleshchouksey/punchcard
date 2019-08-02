import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)

import alert from './alert';
import projects from './projects';
import reports from './reports';
import clients from './clients';
import users from './users';
import checks from './checks';
import payment from './payment';
import report_option_data from './report_option_data';

const state = {
    loading: false,
}

const mutations = {
    LOADING(state, bool) {
        state.loading = bool
    },
}

const actions = {
    loading: ({commit}, bool) => {
        commit('LOADING', bool);
    },
}

export default new Vuex.Store({
    state,
    mutations,
    actions,
    modules: {
        alert,
        projects,
        reports,
        payment,
        clients,
        users,
        checks,
        report_option_data
    },
})
