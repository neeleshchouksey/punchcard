<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    @import '../../../sass/app.bs.css';
    div {
        h4 {
            padding-bottom: 5px;
            border-bottom: 2px solid #ccc;
        }
        h3 {
            margin: auto;
            display: inline-block;
        }
    }
    #add-user-container {
        padding: 20px;
    }
    .fa-plus-circle {
        width: 30px;
        &:hover {
            cursor: pointer
        }
    }
    .fa-check {
        color: $theme-success-green;
    }
    td:nth-child(3){
        text-align: center;
    }
</style>
<template>
  <div id='add-user-container'>
      <loader :loading="loading"></loader>

      <div v-if="computedUsers">

        <input type="text" class="form-control" aria-label="search" placeholder="Find a user to add..."
                                name="searchTerm" v-model="searchFilter">
        <table class="table table-striped" style="border-radius: 15px;">
            <thead>
                <tr>
                    <td>Name</td>
                    <td>Company</td>
                </tr>
            </thead>
            <tbody>
                <tr v-for="user in computedUsers">
                    <td>
                        <router-link :to="{ path: '/user/' + user.uniq_id + '/details' }">
                            {{ user.name }}
                        </router-link>
                    </td>
                   <td>
                        <router-link :to="{ path: '/client/' + user.client_uniq_id }">
                           {{ user.client_name }}
                        </router-link>
                   </td>
                   <td>
                        <transition>
                            <span @click="addToProject(user, $event)" aria-hidden='true'
                                   class="pointer center fa fa-2x fa-plus-circle">
                            </span>
                        </transition>
                    </td>
                </tr>
            </tbody>
        </table>
      </div>
      <div v-else v-show="!loading">
          <h2>No users available</h2>
      </div>
  </div>
</template>
<script>
    //import User from '../../api/user';
    import UX from '../../helpers/UX';

    export default {
        name: 'project-add-user',
        data () {
            return {
                Perm: Perm,
                loading: true,
                searchFilter: null,
                users: []
            }
        },
        created () {
            this.uniq_id = this.$route.params.project_id;

            //
            // We want all users in companies attached to this project
            //
            this.routes     = Api.getRoutes('webapp-projects');

            this.routes.project_users.get(this.uniq_id).then((users) => {
                this.users = users
                this.loading = false;
            });
        },
        computed: {
            computedUsers: function () {

                if (! this.users.length) {
                    return
                }

                if (! this.searchFilter) {
                    return this.users
                }


                let found = _.filter(this.users, function(o) {
                    return o.name.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
                }.bind(this));

                return found;
            }
        },
        components: {
        },
        methods: {
            addToProject: function(user, event) {

                if (UX.alreadyClicked(event)) {
                    return
                }

                UX.setTarget(event).addClicked().removePlus().addSpin()

                let data = {
                    'project_uniq_id': this.uniq_id,
                    'user_uniq_id': user.uniq_id
                }

                this.routes.project_users.post(data).then((result) => {
                  /*this.$store.dispatch('showAlertSuccess',
                      {
                          title: "Success",
                          msg: result.data.message
                      });*/

                    UX.setTarget(event).removeSpin().addCheck()

                    Api.delete(this.uniq_id)
                    Api.delete('project-users-' + this.uniq_id)
                });
            },
        }
    }
</script>
