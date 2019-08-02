const state = {
    title: null,
    msg: null,
    type: "danger",
    show: false
}

const mutations = {
    SHOW_ALERT(state, alertObj) {
        state.title = alertObj.title;
        state.msg   = alertObj.msg;
        state.type  = alertObj.type;
        state.show  = alertObj.show;
    }
}

const actions = {
    dismissAlert: ({commit}, alertObj) => {
        alertObj = {} // clear
        alertObj.show = false;
        commit('SHOW_ALERT', alertObj);
    },
    showAlertInfo: ({commit}, alertObj) => {
        alertObj.show = true;
        alertObj.type = "info";
        commit('SHOW_ALERT', alertObj);
    },
    showAlertSuccess: ({commit}, alertObj) => {
        alertObj.show = true;
        alertObj.type = "success";
        commit('SHOW_ALERT', alertObj);
    },
    showAlertFail: ({commit}, alertObj) => {
        alertObj.show = true;
        alertObj.type = "danger";
        commit('SHOW_ALERT', alertObj);
    }
}

export default {
    state, mutations, actions
}
