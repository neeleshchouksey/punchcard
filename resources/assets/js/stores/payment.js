import store from './index';
import {
	router
} from '../routes.js'

const state = {
	payments: []
};

//
// Think of getters as computed properties for stores
//
const getters = {
	payment: (state, getters) => {}
}

const mutations = {
	GET_PAYMENTS(state, payments) {
		state.payments = payments
	},
};

const actions = {

	getAllTransaction: ({commit}, args) => {
    console.log('in getAllTransaction');
		let routes = Api.getRoutes('webapp-payments');
		return routes.getAllTransaction.post({}).then((response) => {
			return response;
		});
	},

	getCurrentMonthPunchDetails: ({commit}, args) => {
    console.log('in getCurrentMonthPunchDetails');
		let routes = Api.getRoutes('webapp-payments');
		return routes.getCurrentMonthPunchDetails.post({}).then((response) => {
			return response;
		});
	},

	getPayments: ({
		commit
	}, uniq_id = null) => {
		console.log('in get payments')
		let routes = Api.getRoutes('webapp-payments');

		return routes.payment.get().then((payments) => {
			commit('GET_PAYMENTS', payments);
			return payments;
		});
	},

};

export default {
	state,
	getters,
	mutations,
	actions
};
