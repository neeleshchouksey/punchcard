import store from './index'
import {router} from '../routes.js'

const state = {
    checks: {}
}

//
// Think of getters as computed properties for stores
//
const getters = {
}

const mutations = {
}

const actions = {
    punch: ({commit}, inData) => {
        let routes = Api.getRoutes('webapp-check')

        let data = {
            'uniq_id': inData.project_uniq_id,
            'badge_id': inData.badge_id,
            'latitude': 90,
            'longitude': 90,
            'exceptionReason': 'virtual-gate'
        }

        return routes.punch[inData.method](data).then((response) => {
            return response
        }).catch((response) => {
            let msg = getResponseMsg(response)
        })
    },
}

const getResponseMsg = function(response)
{
    let msg

    if (response.data != null && typeof response.data != 'undefined' &&
        response.data.message != null && typeof response.data.message != 'undefined') {
        msg = response.data.message

    } else {
        msg = "" + response.data
    }

    return msg
}

export default {
    state, getters, mutations, actions
}
