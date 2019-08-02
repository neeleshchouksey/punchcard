<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    .input-group {
        display: flex;
        flex-direction: row;
        width: 100%;
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
        input[type='text'] {
            max-width: 80%;
            margin-right: 10px;
        }
        input, button {
            height: 100%;
            margin: 0;
            padding: 10px;
        }
        button  {
            width: 100%;
            span {
                margin: 5px;
            }
        }
        .input-group-btn {
            width: 150px;
        }
    }
    button.btn-spaced {
        margin-top: 5px ;
        margin-bottom: 5px ;
    }

    ul.dd-filter {
        li {
            margin: 10px;
            padding: 0;
            list-style-type: none;
        }
    }
    .dropdown-menu {
        padding: 5px;
        margin: 0;
        color: #111;
        li {
            margin: 0 !important;
            padding: 10px !important;
            &:hover, *:hover {
                background-color: $theme-gold;
                cursor: pointer;
            }
        }
    }
    #add-user {
        margin-left: 20px;
        margin-top: 20px;
    }
    #users {
        padding: 15px 20px;
    }
      thead tr {
          background-color: $theme-gold;
      }
      tr {
          padding: 5px;
          padding-bottom: 20px;
      }

      td {
          vertical-align: center;
          text-align: center;
          &:first-child {
              text-align: left;
          }
      }

      tbody tr {
          &:nth-child(odd) {
              background-color: lighten($theme-gold, 25%);
          }
      }

      tr.sort td:hover {
          cursor: pointer;
          background: $laravel-border-color;
      }
</style>
<template>
    <div>
        <router-link v-permission="'ProjectsUsers'"
             :to="{name: 'project-add-user', params: { project_id: project_id}}">
            <button type="button" class="btn-spaced btn btn-default material" id='add-user'>Add User</button>
        </router-link>

        <div id="users" v-if="computedUsers || loading">

                <div class="input-group">
                    <input type="text" class="form-control" aria-label="search" placeholder="Search for..."
                        name="searchTerm" v-model="searchFilter">
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-default dropdown-toggle"
                            data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false">
                                {{ searchSelectedValue }} <span class="caret"></span>
                        </button>

                        <input type="hidden" v-model="searchSelectedValue" />
                        <ul class="dropdown-menu dropdown-menu-right">
                            <li @click="setSearchSelectedValue">All Roles</li>
                            <li @click="setSearchSelectedValue">User</li>
                            <li @click="setSearchSelectedValue">Superuser</li>
                            <!-- <li @click="setSearchSelectedValue">Admin</li> -->
                            <li @click="setSearchSelectedValue">Clientadmin</li>
                        </ul>
                    </div>
                </div>


                <div>
                    <table class="table table-striped" style="border-radius: 15px;">
                        <thead>
                            <tr class="sort">
                                <td @click="sortRows('first_name')"><i class="fa fa-sort"></i>Name</td>
                                <td @click="sortRows('mobileNumber')"><i class="fa fa-sort"></i>Phone</td>
                                <td>Email</td>
                                <td>Scanner Access</td>
                                <td @click="sortRows('role')"><i class="fa fa-sort"></i>Role</td>
                                <td @click="sortRows('client_name')"><i class="fa fa-sort"></i>Company</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-if="loading">
                                <td colspan="7" style="text-align: left;">
                                    <loader size="7" loading_msg="Checking for users ..." :loading="true"></loader>
                                </td>
                            </tr>
                            <template v-if="!loading" v-for="user in computedUsers">
                                <users-row :user="user" :project="project" v-show="shouldShow(user)"></users-row>
                            </template>
                        </tbody>
                    </table>
             </div>
        </div>
        <div v-else>
            <div><b>No users found.</b></div>
        </div>
    </div>
</template>
<script>
    import UsersRow from '../components/UsersRow.vue'

    export default {
        name: 'project-users',
        data () {
            return {
                Perm: Perm,
                searchSelectedValueReactive: 'All Roles',
                orderBy: ['first_name'],
                orderDir: ['desc'],
                loading: true,
                users: [],
                project: {
                    users: []
                },
                searchFilter: null
            }
        },
        components: {
            UsersRow
        },
        created () {
            this.project_id = this.$route.params.project_id;

            this.$store.dispatch('getProject', this.$route.params.project_id).then(() => {  // project_id == uniq_id
                this.project = this.$store.state.projects.project;
                this.users   = this.project.staffed;
                this.loading = false;
            });
        },
        computed: {
            searchSelectedValue: function () {
                return this.searchSelectedValueReactive;
            },
            computedUsers: function () {

                if (this.users === null) {
                    return;
                }

                if (! this.users.length) {
                    return;
                }

                let found = _.filter(this.users, function(o) {
                    return this.isRole(o.role) && this.isMatch(o);
                }.bind(this));

                //found = _.sortBy(found, 'first_name');
                return _.orderBy(found, this.orderBy, this.orderDir)
            }
        },
        methods: {
          sortRows: function(orderBy)
          {
              if (this.users.length <= 0) {
                  return
              }

              this.orderBy = [orderBy]
              this.orderDir = (this.orderDir.indexOf('desc') > -1) ? ['asc'] : ['desc']
              this.users = _.orderBy(this.users, this.orderBy, this.orderDir)
          },
            shouldShow(user) {
                return this.isRole(user.role) && this.isMatch(user);
            },

            isMatch(o) {
                if (this.searchFilter === null) {
                    return true;
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
