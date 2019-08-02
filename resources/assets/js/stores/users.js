import store from './index';
import User from '../api/user';
import formatHelper from '../helpers/format';
import {router} from '../routes';

const state = {
    timesheets: [],
    Authorized: false,
    addForm: {},
    users: [],
    user: {},
    queue: {}
}

//
// Think of getters as computed properties for stores
//
const getters = {
}

const mutations = {
    SAVE_ADD_FORM_DATA(state, data) {
        data.exists = true
        state.addForm = data
    },
    REMOVE_ADD_FORM_DATA(state) {
        state.addForm = {}
    },
    GET_USERS(state, users) {
        state.users = users
    },
    GET_USER(state, user) {
        state.user = user
    },
    SAVE_TO_QUEUE(state, variable) {
        let key

        if (typeof variable.key !== 'undefined') {
            key = variable.key
        } else {
            key = variable.uniq_id
        }

        state.queue[key] = variable
    },
    UPDATE_USER(state, user) {
    },
    ALTER_AUTHORIZED(state, data) {
        state.Authorized = data
    },
    DELETE_USER(state, uniq_id) {
        if (uniq_id == User.profile().uniq_id) {
            User.logout();
            window.location.replace('/');
        }
    },
    // TOGGLE_SCANNER(state, user) {
    //     let updateAt = _.findIndex(state.user.users, ['uniq_id', user.uniq_id])
    //     state.user.users.splice(updateAt, 1,  user)
    // },
    GET_BADGE(state, badge) {
        state.badge = badge
    },

    GET_TIMESHEETS(state, timesheets) {
        let format = 'YYYY-MM-DD h:mm a';

        state.timesheets = _.map(timesheets, function(sheet) {
            sheet.checkInDateTimeFormatted = formatHelper.date(sheet.checkInDateTime, format);
            sheet.checkOutDateTimeFormatted = formatHelper.date(sheet.checkOutDateTime, format);

            sheet.checkInDateTime = formatHelper.date(sheet.checkInDateTime, 'YYYY-MM-DD HH:mm:ss');
            sheet.checkOutDateTime = formatHelper.date(sheet.checkOutDateTime, 'YYYY-MM-DD HH:mm:ss');

            return sheet;
        });
    },

    UPDATE_TIMESHEET(state, timesheet) {
        let format = 'YYYY-MM-DD h:mm a';
        let updateAt = _.findIndex(state.timesheets, ['uniq_id', timesheet.uniq_id])

        let sheet = state.timesheets[updateAt];
        sheet.checkInDateTime = formatHelper.date(sheet.checkInDateTime, 'YYYY-MM-DD HH:mm:ss');
        sheet.checkOutDateTime = formatHelper.date(sheet.checkOutDateTime, 'YYYY-MM-DD HH:mm:ss');
        sheet.checkInDateTimeFormatted = formatHelper.date(timesheet.checkInDateTime, format);
        sheet.checkOutDateTimeFormatted = formatHelper.date(timesheet.checkOutDateTime, format);

        state.timesheets.splice(updateAt, 1,  sheet)
    },
}

const actions = {
    imp: ({commit}, user) => {

        Api.post('/webapp/imp', {'email': user.email}).then(response => {

            let auth = Api.retrieve('auth');
            auth.access_token = response.data.data.info;

            //
            // Open a new window, log out with message
            //
            new Promise((resolve,reject) => {
                let url = '/projects';
                window.open(url, '_blank'); // will have Impersonate data
                resolve();
            }).then(() => {
                store.dispatch('showAlertSuccess', {title: 'Impersonate Login', msg: 'Your new impersonate session has opened in a new window, please complete tasks there and then return here when you are through, close that window and log back in as yourself.'});
                router.push('/logout'); // current window, will go to a page that shows a logged-out message
            }).then(() => {
                let routes = Api.getRoutes('webapp-user');
                    routes.login.update(auth); // updates the localStorage with the new auth data
            });
        }).catch((response) => {
            console.log('Error in process');
        });
    },
    alterAuthorized: ({commit}, data) => {
        commit('ALTER_AUTHORIZED', data)
    },
    deleteUser: ({commit}, data) => {
        //Api.delete(data.uniq_id)
        commit('DELETE_USER', data.uniq_id)
    },
    addFormSave: ({commit}, data) => {
        commit('SAVE_ADD_FORM_DATA', data)
    },
    addFormRemove: ({commit}) => {
        commit('REMOVE_ADD_FORM_DATA')
    },
    getUsers: ({commit}, uniq_id = null) => {
        let routes     = Api.getRoutes('user-admin')

        return routes.user.get().then((users) => {
            commit('GET_USERS', users)
            return users
        })
    },

    getUser: ({commit}, uniq_id) => {

        let user

        if (existsInQueue[uniq_id]) {
            user = state.queue[uniq_id]
            commit('GET_USER', user)
        } else {
            let routes     = Api.getRoutes('user-admin')

            user = routes.user.get(uniq_id).then((user) => {
                commit('GET_USER', user)
                commit('SAVE_TO_QUEUE', user)
                return user
            }).catch((response) => {
                let msg
                if (response.data.message != null && typeof response.data.message != 'undefined') {
                    msg = response.data.message
                } else {
                    msg = "" + response.data
                }

                commit('GET_USER', {})

                store.dispatch('showAlertFail', {title: 'Retrieval error', msg: msg})
            })
        }

        return user
    },

    updateTimesheet: ({commit}, timesheet) => {
        console.log(timesheet);
        commit('UPDATE_TIMESHEET', timesheet)
    },

    getTimesheets: ({commit}, uniq_id) => {
        let timesheets;
        let routes = Api.getRoutes('user-admin');

        timesheets = routes.timesheets.get(uniq_id).then((timesheets) => {
            commit('GET_TIMESHEETS', timesheets)
            return timesheets
        }).catch((response) => {
            let msg
            if (response.data != null && typeof response.data != 'undefined' &&
                response.data.message != null && typeof response.data.message != 'undefined') {
                msg = response.data.message

            } else {
                msg = "" + response.data
            }

            commit('GET_TIMESHEETS', {})
            store.dispatch('showAlertFail', {title: 'Retrieval error', msg: null})
        })

        return timesheets
    },

    getBadge: ({commit}, data) => {

        let user_uniq_id    = data[0]
        let project_uniq_id = data[1]
        let badge

        let queueKey = 'badge:' + user_uniq_id + ':' + project_uniq_id

        if (existsInQueue[queueKey]) {
            badge = state.queue[queueKey]
            commit('GET_BADGE', badge)
        } else {
            let routes     = Api.getRoutes('user')
            badge = routes.badge.get(user_uniq_id, project_uniq_id).then((badge) => {

                badge.uniq_id = queueKey

                commit('GET_BADGE', badge)
                commit('SAVE_TO_QUEUE', badge)
                return badge
            }).catch((response) => {
                let msg
                if (response.data != null && typeof response.data != 'undefined' &&
                    response.data.message != null && typeof response.data.message != 'undefined') {
                    msg = response.data.message

                } else {
                    msg = "" + response.data
                }

                commit('GET_BADGE', {})
            })
        }

        return badge
    }
}

const existsInQueue = function (key) {
    if (typeof state.queue[key] != 'undefined' &&
        state.queue[key] != null &&
        state.queue[key] != 'undefined' &&
        state.queue[key] != undefined) {
            return true
    }

    return false
}

export default {
    state, getters, mutations, actions
}
