let apiPromise = require('../api-promise.js').default
let Config = require('../../config').default

export default {
    caller: null,

    setCaller: (Caller) => {
        this.caller = Caller;
    },

    //
    // Using jquery because the Api sends headers
    // the weather service doesn't like (Authorization,
    // CSRF)
    //
    weather: {
        forecast: (zip) => {
            let endpoint = Config.getWeatherForecastUrl(zip)
            return new Promise((resolve, reject) => {
                let data = $.get(endpoint, function(data) {
                    return data
                });
                resolve(data)
            }).catch(response => {
                console.log('Error in submission');
            });
        },
        current: (zip) => {
            let endpoint = Config.getWeatherCurrentUrl(zip)
            return new Promise((resolve, reject) => {
                let data = $.get(endpoint, function(data) {
                    return data
                });
                resolve(data)
            }).catch(response => {
                console.log('Error in submission');
            });
        }
    }
}
