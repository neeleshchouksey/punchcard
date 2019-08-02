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
    #add-client-container {
        padding: 20px;
    }
</style>
<template>
  <div id='add-client-container'>

      <loader :loading="loading"></loader>

      <div v-if="!loading && !computedClients">
          <h3>No Companies available to add. Go to Organization to add child companies.</h3>
      </div>

      <div v-if="computedClients">

        <input type="text" class="form-control" aria-label="search" placeholder="Find a company to add..."
                                name="searchTerm" v-model="searchFilter">
         <table class="table table-striped" style="border-radius: 15px;">
             <thead>
                <tr>
                    <td style="width: 70%;">Name</td>
                    <td>Company</td>
                    <td>Add All Employees</td>
                </tr>
              </thead>
              <tbody>
                    <tr v-for="client in computedClients">
                        <td>{{ client.name }}</td>
                        <td>
                            <span @click="addToProject(client, $event)" aria-hidden='true'
                                class="fa fa-2x fa-plus-circle center pointer">
                            </span>
                        </td>
                        <td>
                            <span @click="addAllUser(client, $event)" aria-hidden='true'
                                class="fa fa-2x fa-plus-circle center pointer">
                            </span>
                        </td>
                    </tr>
                </tbody>
          </table>
      </div>
  </div>
</template>
<script>
    import UX from '../../helpers/UX';

    export default {
        name: 'project-add-client',
        data () {
            return {
                searchFilter: null,
                Perm: Perm,
                loading: true,
                clients: []
            }
        },
        created () {
            this.uniq_id = this.$route.params.project_id;

            //
            // We want all clients attached to this project
            //
            this.routes     = Api.getRoutes('webapp-projects');

            this.routes.project_clients.get(this.uniq_id).then((clients) => {
                this.clients = clients;
                this.loading = false;
            });
        },
        computed: {
            computedClients: function () {

                if (! this.clients.length) {
                    return
                }

                if (! this.searchFilter) {
                    return this.clients
                }

                let found = _.filter(this.clients, function(o) {
                    return o.name.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
                }.bind(this));

                return found;
            }
        },
        components: {
        },
        methods: {
            addToProject: function(client, event) {

                if (UX.alreadyClicked(event)) {
                    return
                }

                UX.setTarget(event)
                  .addClicked()
                  .removePlus()
                  .addSpin()

                let data = {
                    'project_uniq_id': this.uniq_id,
                    'client_uniq_id': client.uniq_id
                }

                this.routes.project_clients.post(data).then((result) => {
                    UX.setTarget(event).removeSpin().addCheck()

                    Api.delete(this.uniq_id)
                    Api.delete('project-clients-' + this.uniq_id)
                });
            },
            addAllUser: function(client, event) {

                if (UX.alreadyClicked(event)) {
                    return
                }

                UX.setTarget(event)
                  .addClicked()
                  .removePlus()
                  .addSpin()

                let data = {
                    'project_uniq_id': this.uniq_id,
                    'client_uniq_id': client.uniq_id
                }

                this.routes.project_child_user.post(data).then((result) => {
                    UX.setTarget(event).removeSpin().addCheck()
                    Api.delete(this.uniq_id)
                    Api.delete('project-clients-' + this.uniq_id)
                });
            },
        }
    }
</script>
