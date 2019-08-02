require('./bootstrap');
//Vue.config.devtools = true

import VueResource from 'vue-resource';
Vue.use(VueResource)

import store from './stores/index';
import User from './api/user'
import App from './pages/App.vue'
import {router} from './routes.js'

window.Perm = require('./permissions.js').default
window.Api = require('./api/caller.js').default
Api.setUp(User, Vue.http)

window.User = User

Vue.directive('permission', {
    inserted: function (el, binding) {
        let where = binding.value
        if (Perm.has(where) !== true) {
            el.remove()
        }
    }
})

Vue.directive('no-permission', {
    inserted: function (el, binding) {
        let where = binding.value
        if (Perm.has(where) !== false) {
            el.remove()
        }
    }
})

Vue.directive('phone', {
    updated: function (el, binding) {
    // return phone.replace(/[^0-9]/g, '')
    //             .replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
    }
});

router.beforeEach((to, from, next) => {

    if (typeof to.meta.publicAccess !== 'undefined' && to.meta.publicAccess === true) {
        next()
    }

    if (! User.auth() && to.path !== '/' && to.path !== '' && window.location.pathname !== '' && window.location.pathname !== '/') {
        next({name: 'home'});
    }

    // if (! to.meta.hasPermission('something')) {
    //     next({name: 'no-permissions'});
    // }

    next()
});

let vueOptions = {
    store,
    router,
    User,
    created: function () {
   //     this.User = User;
    },
    components: {
        App
    },
    data: function() {
        return {
            User: window.User,
        }
    },
    computed: {
    }
}

if (User.authData()) {
    let routes  = Api.getRoutes('webapp-user');
    routes.profile.get().then((responseBody) => {
        window.User.setProfile(responseBody);
        window.Perm.setRole(window.User.auth());
        store.state.users.Authorized = true;
        const app = new Vue(vueOptions).$mount('#app');
    }).catch((result) => {
        new Promise((resolve, reject) => {
            resolve(localStorage.clear());
        }).then(() => {
            window.location.replace('/');
        });
    });
} else {
    const app = new Vue(vueOptions).$mount('#app')
}
