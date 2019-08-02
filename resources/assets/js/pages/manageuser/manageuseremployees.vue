<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {
        .dropdown-menu {
            padding: 3px 10px;
            cursor: pointer;
        }
    }
</style>
<template>
    <div>
        <loader :loading="loading" loading_msg="Loading Employees..."></loader>

        <div v-show="!loading">

            <router-link :to="{name: 'manage-admin-user-add', params: {uniq_id: uniq_id}}">
                <button class="btn btn-primary" aria-expanded="false">
                    Add New Employee
                </button>
            </router-link>

            <div v-if="usersFound">

                <div class="input-group">
                    <input type="text" class="form-control" aria-label="search" placeholder="Search for..."
                        name="searchTerm" v-model="searchFilter">
                </div>

                <div v-show="!loading">
                    <table class="table table-striped" style="border-radius: 15px;">
                        <thead>
                            <tr>
                                <td>Name</td>
                                <td>Phone</td>
                                <td>Email</td>
                                <td>Role</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="user in computedUsers">
                                <td><router-link :to="{ path: '/manage-admin-userdetails/' + user.uniq_id + '/details'}">{{ user.name }}</router-link></td>
                                <td>{{ user.mobileNumber }}</td>
                                <td>{{ user.email }}</td>
                                <td>{{ user.role }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
             </div>

             <div v-else>
                <div><h3>No employees found</h3></div>
             </div>
        </div>
    </div>
</template>
<script>

    export default {
        name: 'manageuser-employees',
        data () {
            return {
                loading: true,
                searchSelectedValueReactive: 'All Roles',
                users: [],
                searchFilter: null
            }
        },
        components: {
        },
        created () {
            this.uniq_id = this.$route.params.uniq_id;

            let routes     = Api.getRoutes('webapp-client');

            routes.client.get(this.uniq_id).then((client) => {
                this.client  = client;
                this.users   = client.users;
                this.loading = false;
            });
        },
        computed: {
            searchSelectedValue: function () {
                return this.searchSelectedValueReactive;
            },
            usersFound: function () {
                return this.users.length;
            },
            computedUsers: function () {

                if (! this.users.length) {
                    return;
                }

                let ret = [];

                for (let i = 0; i < this.users.length; i++) {
                    let user = this.users[i];
                    ret.push(user);
                }

                let found = _.filter(ret, function(o) {
                    return this.isRole(o.role) && this.isMatch(o);
                    // && o.username!=User.profileData.username
                }.bind(this));

                found = _.sortBy(found, 'last_name');
                return found;
            }
        },
        methods: {
            isMatch(o) {
                if (this.searchFilter === null) {
                    return true
                }

                let all = o.name + ' ' + o.mobileNumber + ' ' + o.email;
                return all.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
            },
            isRole(role) {
                let activeRole = this.searchSelectedValue.toLowerCase();

                switch (activeRole) {
                    case 'user':
                    case 'superuser':
                    case 'admin':
                    case 'clientadmin':
                        return activeRole == role;
                        break;

                    default:
                        return true; // All
                }
            },
            setSearchSelectedValue: function (val) {
                this.searchSelectedValueReactive = val.srcElement.innerText;
            }
        }
    }
</script>
