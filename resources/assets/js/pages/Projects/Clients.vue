<style lang="sass" scoped>
  @import '../../../sass/_variables.scss';
    td {
        vertical-align: middle !important;
        height: 100%;
    }
    td:nth-child(3) {
        text-align: center;
    }

      .content-box{
        height: 135px;
        margin: 10px;


      }
        .content-section{
              height: 100%;

          color: $list-element-major-font-color;
          background-color: $list-element-major-bg;
          border: 1px solid transparent;
          border-color: $list-element-major-border;
          border-radius: $general-border-radius;
        }
        .content-section:hover {
            background-color: $list-element-major-hover-bg;
            border-color: $list-element-major-hover-border;
        }
</style>
<template>
    <div>
        <router-link :to="{name: 'project-add-client', params: { project_id: project_id}}" v-permission="'ProjectsAlter'">
            <button type="button" class="btn-spaced btn btn-default material" id='add-user'>Add Company</button>
        </router-link>

        <button style="width: 101px;margin-left: 16px;float: right;" v-if="!listView" @click="listView = !listView">List</button>
        <button style="width: 101px;margin-left: 16px;float: right;" v-if="listView" @click="listView = !listView">Grid</button>

        <div v-if="clientsFound">
            <table v-if="listView" class="table table-striped" style="border-radius: 15px;">
                <tbody>
                    <tr v-for="client in computedClients">
                        <td>
                            <secure-img :src="client.logo" className="size-125 img-rounded img-responsive"></secure-img>
                        </td>
                        <td>
                            <router-link :to="{ path: '/child/' + client.uniq_id + '/summary' }">
                                <h3>{{ client.name }}</h3>
                            </router-link>
                        </td>
                        <td>
                            <span @click="removeFromProject(client, $event)"
                                class="center pointer fa fa-2x fa-times"></span>
                            </span>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div v-if="!listView">
              <div class="col-sm-6 " v-for="client in computedClients">
                <div class="content-box">
                  <div class="row content-section">
                    <div class="image col-sm-4">
                      <secure-img :src="client.logo" className="img-rounded img-responsive" title=""></secure-img>
                    </div>
                    <div class="details row">
                      <div class="col-sm-6">
                        <router-link v-if="client.uniq_id" :to="{name: 'child-summary', params: {uniq_id: client.uniq_id}}">
                          <h3>{{ client.name }}</h3>
                        </router-link>
                      </div>
                      <div class="col-sm-1">
                        <span @click="removeFromProject(client, $event)"
                        class="center pointer fa fa-2x fa-times"></span>
                      </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
         </div>
         <div v-else>
             <div><h3>{{ clientsStatus }}</h3></div>
            <loader :loading="loading"></loader>
         </div>
    </div>
</template>
<script>
    import SecureImg from '../../components/SecureImg.vue';
    import UX from '../../helpers/UX';

    export default {
        name: 'project-clients',
        data () {
            return {
              listView : false,
                clientsFound: false,
                loading: true,
                clientsStatus: 'Looking for clients ...',
                searchSelectedValueReactive: 'All Roles',
                project: {
                    clients: []
                },
                searchFilter: null
            }
        },
        components: {
            SecureImg
        },
        created () {
            this.routes = Api.getRoutes('webapp-projects');

            this.project_id = this.$route.params.project_id;

            this.$store.dispatch('getProject', this.$route.params.project_id).then((project) => {  // project_id == uniq_id
                this.project = project
                this.clientsFound = this.project.clients.length > 1;
                this.clientsStatus = !this.clientsFound ? 'No clients found' : ''; // client that owns project does't count
                this.loading = false
            });
        },
        computed: {
            computedClients: function () {

                if (! this.project.clients.length) {
                    return;
                }

                let found = _.filter(this.project.clients, function(o) {
                    return this.isMatch(o) && !this.isParentCompany(o);
                }.bind(this));

                return found;
            }
        },
        methods: {
            removeFromProject(client, event) {

                if (!confirm('Really remove this company from this project?')) {
                    return;
                }

                UX.setTarget(event)
                  .addClicked()
                  .removeTimes()
                  .addSpin();

                let data = {
                    'project_uniq_id': this.project.uniq_id,
                    'client_uniq_id': client.uniq_id
                }

                this.routes.project_clients.put(data).then((result) => {
                    UX.setTarget(event).removeSpin().addBan();
                });
            },
            isParentCompany(o)
            {
                return (o.child_of_id == 0);
            },
            isMatch(o)
            {
                if (this.searchFilter === null) {
                    return true;
                }

                let all = o.name + ' ' + o.mobileNumber + ' ' + o.email;
                return all.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
            },
        }
    }
</script>
