import store from '../stores/index';

export default {

    headers: [],
    lastCall: {},

    getRoutes: function (route_set)
    {
        let routes = require('./routes/' + route_set.toLowerCase()).default;
        routes.setCaller(this);
        return routes;
    },

    refresh: function ()
    {
        this.config = require('../config.js').default
        this.http.options.root = this.config.preUrl();
    },

    rebuild: function (auth)
    {
        this.config = require('../config.js').default
        this.http.options.root = this.config.preUrl();
        this.http.headers.common['Authorization'] = 'Bearer ' + auth.access_token
        this.http.headers.common['Accept'] = 'application/json';
        this.http.headers.common['Content-type'] = 'application/json';
        this.http.headers.common['Content-Type'] = 'application/json';
        //this.http.headers.common['Cache-Control'] = 'public, max-age=3600';

        this.http.headers.common['X-CSRF-TOKEN'] = $('meta[name="csrf-token"]').attr('content')
    },

    setUp: function (User, Http) {
        this.http   = Http;
        this.rebuild(User.authData());
    },

    inject: function (name, val) {
        this[name] = val;
    },

    addHeader: function (obj) {
        this.headers.push(obj);
    },

    fetch: function (endpoint)
    {
        let url = this.getUrl(endpoint);
        return this.http.get(url).then((response) => {
            this.lastCall = response;
            return response.body.data;
        }).catch((response) => {

            return Promise.reject(response);

        });
    },

    //
    // Sends as key=value&key2=value2 not as JSON
    //
    realpost: function (endpoint, data, options = {})
    {

    return new Promise((resolve, reject) => {
        let url = this.getUrl(endpoint);
        $.ajax({
          type: 'POST',
          beforeSend: function(request)
          {
            request.setRequestHeader('X-CSRF-TOKEN', $('meta[name="csrf-token"]').attr('content'));
          },
          url: url,
          data: data,
          success: function(data)
          {
            resolve(data);
          },
          dataType: 'html'
        });
    });



        //
        // console.log(url);
        // console.log(options);
        // options.emulateJSON = true;
        // options.root = '';
        // console.log(options);
        // return this.http.post(url, data, options).then((response) => {
        //     this.lastCall = response;
        //     return response;
        // }).catch((response) => {
        //     this.handleBadRequest(response)
        //     return Promise.reject(response);
        // });
    },

    post: function (endpoint, data, options = {})
    {
        let url = this.getUrl(endpoint);
        return this.http.post(url, data, options).then((response) => {
            this.lastCall = response;
            return response;
        }).catch((response) => {
            this.handleBadRequest(response)
            return Promise.reject(response);
        });
    },

    postWithoutHandling: function (endpoint, data, options = {})
    {
        let url = this.getUrl(endpoint);
        return this.http.post(url, data, options).then((response) => {
            this.lastCall = response;
            return response;
        }).catch((response) => {
            //this.handleBadRequest(response)
            return Promise.reject(response);
        });
    },

    put: function (endpoint, data)
    {
        let url = this.getUrl(endpoint);
        return this.http.put(url, data).then((response) => {
            this.lastCall = response;
            return response;
        }).catch((response) => {
            this.handleBadRequest(response)
            //
            // Allow more processing on the vue that called it
            //
            return Promise.reject(response);
        });
    },

    handleBadRequest: function(response)
    {
        switch (response.status) {
            case 500:
                store.dispatch('showAlertFail',
                {
                    title: "Server Error",
                });
                break;
            case 422:
                store.dispatch('showAlertFail',
                {
                    title: "Error in submission",
                    msg: response.body.message.split(',').join("\r\n")
                });
                        //msg: '<ul><li>' + response.body.message.split(',').join('</li><li>') + '</li></ul>'
                break;
        }
    },

    get: function (endpoint, data)
    {
        let url = this.getUrl(endpoint);
        return this.http.get(url, {"params": data}).then((response) => {
            this.lastCall = response;
            return response;
        }).catch((response) => {
            this.handleBadRequest(response)
            //
            // Allow more processing on the vue that called it
            //
            return Promise.reject(response);
        });
    },

    del: function (endpoint, data)
    {
        let url = this.getUrl(endpoint + '/' + data.uniq_id);
        return this.http.delete(url).then((response) => {
            this.lastCall = response;
            return response;
        }).catch((response) => {
            this.handleBadRequest(response)
            //
            // Allow more processing on the vue that called it
            //
            return Promise.reject(response);
        });
    },

    getUrl: function(endpoint)
    {
        let url;

        if (endpoint.indexOf('web:') === 0) {
            url = endpoint.replace('web:', '');
        } else if (endpoint.indexOf('http') === 0) {
            url = endpoint;
        } else {
            url = this.http.options.root + endpoint;
        }

        return url;
    },

    update: function(key, data) {
        let val = this.retrieve(key)
        let newVal = _.merge(val, data)
        this.store(key, newVal)
    },

    store: function(key, data) {
        localStorage.setItem(key, JSON.stringify(data));
    },

    delete: function(key) {
        localStorage.removeItem(key);
    },

    retrieve: function(key) {

        let unparsedData = localStorage.getItem(key)

        if (unparsedData != null && typeof unparsedData != 'undefined' && unparsedData != 'undefined' && unparsedData != undefined) {
            return JSON.parse(unparsedData)
        }

        return null
    }

}
