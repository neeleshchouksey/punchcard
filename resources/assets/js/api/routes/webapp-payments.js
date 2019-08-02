let apiPromise = require('../api-promise.js').default;
let Config = require('../../config.js').default;

export default {

	caller: null,

	setCaller: (Caller) => {
		this.caller = Caller;
	},

	toggle: {
		get: (data) => {
			let endpoint = '/webapp/reports/toggle/'
			return this.caller.post(endpoint, data)
		}
	},

	export: {
		pdf: (data) => {
			data = {
				user_id: User.profileData.id,
				client_id: User.profileData.client_id,
			};
			return Api.post(Config.domainName + 'api/crons/download_txnHistory', data, {
				responseType: 'arraybuffer'
			}).then((response) => {
				return response;
			}).catch((response) => {
				return Promise.reject(response);
			});
		},
	},

	getAllTransaction: {
		post: (data) => {
			console.log(Config.domainName);
			let endpoint = Config.domainName + 'api/crons/punch_history';
			data = {
				user_id: User.profileData.id,
				client_id: User.profileData.client_id,
			};
			return this.caller.post(endpoint, data);
		}
	},
	getCurrentMonthPunchDetails: {
		post: (data) => {
			let endpoint = Config.domainName + 'api/crons/currentMonthPunch';
			data = {
				user_id: User.profileData.id,
				client_id: User.profileData.client_id,
			};
			return this.caller.postWithoutHandling(endpoint, data);
		}
	},


	report_option_data: {
		get: (uniq_id) => {
			return new apiPromise(this.caller, '/webapp/reporting/option-data/' + uniq_id, 'report_option_data');
		},
	},

	payment: {
		get: (uniq_id = null, refresh = false) => {
			let endpoint;
			console.log('in payment get');
			if (!uniq_id) {
				uniq_id = 'reports'
				endpoint = '/webapp/reports'
			} else {
				endpoint = '/webapp/reports/' + uniq_id;
			}
			return new apiPromise(this.caller, endpoint, uniq_id, refresh);
		},
	},
}
