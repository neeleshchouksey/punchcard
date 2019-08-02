import store from './index';
import {router} from '../routes.js'

const state = {
    clients: [],
    client: {},
    clientQueue: {}
}

//
// Think of getters as computed properties for stores
//
const getters = {
}

const mutations = {
    GET_CLIENTS(state, clients) {
        state.clients = clients
    },
    GET_CLIENT(state, client) {
        state.client = client
    },
    SAVE_CLIENT_TO_QUEUE(state, client) {
        state.clientQueue[client.uniq_id] = client;
    }
}

const actions = {
    getClients: ({commit}, uniq_id = null) => {
        let routes     = Api.getRoutes('webapp-clients');

        routes.clients.get().then((clients) => {
            commit('GET_CLIENTS', clients);
        });
    },

    deleteClient: ({commit}, data) => {
        let routes     = Api.getRoutes('webapp-client');

        return routes.client.del(data).then((client) => {
            return client;
        });
    },

    getClient: ({commit}, uniq_id) => {

        let client;

        if (typeof state.clientQueue[uniq_id] != 'undefined' &&
            state.clientQueue[uniq_id] != null &&
            state.clientQueue[uniq_id] != 'undefined' &&
            state.clientQueue[uniq_id] != undefined) {

                client = state.clientQueue[uniq_id];
                commit('GET_CLIENT', client);

        } else {
            let routes     = Api.getRoutes('webapp-client');

            client = routes.client.get(uniq_id).then((client) => {
                commit('SAVE_CLIENT_TO_QUEUE', client);
                commit('GET_CLIENT', client);
                return client;
            }).catch((response) => {
                let msg;
                if (response.data.message != null && typeof response.data.message != 'undefined') {
                    msg = response.data.message;
                } else {
                    msg = "" + response.data;
                }

                commit('GET_CLIENT', {});

                store.dispatch('showAlertFail', {title: 'Retreival error', msg: msg});
            });
        }

        return client;
    }
}

export default {
    state, getters, mutations, actions
}
