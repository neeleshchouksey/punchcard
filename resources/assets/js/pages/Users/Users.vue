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
        <loader :loading="loading" loading_msg="Loading Users..."></loader>

        <div v-show="!loading">
            <h3>Users</h3>

            <div v-if="usersFound">
                <div class="input-group">
                    <input type="text" class="form-control" aria-label="search" placeholder="Search for..."
                        name="searchTerm" v-model="searchFilter">
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-default dropdown-toggle"
                            style="width: 150px"
                            data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false">
                                {{ searchSelectedValue }} <span class="caret"></span>
                        </button>

                        <input type="hidden" v-model="searchSelectedValue" />
                        <ul class="dropdown-menu dropdown-menu-right">
                            <li @click="setSearchSelectedValue">All Roles</li>
                            <li @click="setSearchSelectedValue">User</li>
                            <li @click="setSearchSelectedValue">Superuser</li>
                            <li @click="setSearchSelectedValue">Admin</li>
                            <li @click="setSearchSelectedValue">Superadmin</li>
                        </ul>
                    </div>
                </div>

                <users-table :project_id="this.project.id" :users="computedUsers"></users-table>
             </div>
             <div v-else>
                <div><b>No users found</b></div>
             </div>
        </div>
    </div>
</template>
<script>
    import UsersTable from '../../components/UsersTable.vue'

    export default {
        name: 'users',
        data () {
            return {
                loading: true,
                searchSelectedValueReactive: 'All Roles',
                users: [],
                searchFilter: null
            }
        },
        components: {
            UsersTable
        },
        created () {
            Project.loadProject(this.$route.params.project_id).then((project) => {
                this.project = project;
                this.users = project.users;
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

                if (this.searchFilter === null) {
                    return ret;
                }

                let found = _.filter(ret, function(o) {
                    return this.isRole(o.role) && this.isMatch(o.name);
                }.bind(this));

                return found;
            }
        },
        methods: {
            isMatch(name) {
                return name.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
            },
            isRole(role) {
                let activeRole = this.searchSelectedValue.toLowerCase();

                switch (activeRole) {
                    case 'user':
                    case 'superuser':
                    case 'admin':
                    case 'superadmin':
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
