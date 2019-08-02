<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
          .content-box{
            height: 140px;
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
              .details-text{
                font-size: 17px;
    margin: 6px 0px 0px 0px;
              }
                .img-rounded{
                      height: -webkit-fill-available;
                }
</style>


<template>
    <div>
        <loader :loading="loading"></loader>

        <div  v-show="!loading">

            <router-link :to="{name: 'client-new', params: { uniq_id: client.uniq_id}}">
                <button type="button" class="btn-spaced btn btn-default">Add Child Company</button>
            </router-link>

            <!-- <ul>
              <li v-for="client in computedClients">
                <router-link :to="{ path: '/child/' + client.uniq_id + '/summary'}">
                    <div class="row">
                        <div class="image col-sm-3">
                            <secure-img :src="client.logo" className="img-rounded img-responsive" title=""></secure-img>
                        </div>
                        <div class="details col-sm-9">
                            <h2>
                                {{ client.name }}
                            </h2>
                        </div>
                    </div>
                </router-link>
              </li>
            </ul> -->
            <div  class="row">
            <div class="col-sm-6" v-for="client in computedClients">
              <div class="content-box">
                <div class="row content-section">
                <router-link :to="{ path: '/child/' + client.uniq_id + '/summary'}">
                    <div class="image col-sm-4">
                      <secure-img :src="client.logo" className="img-rounded img-responsive" title="" style="width: 115px;"></secure-img>
                    </div>
                    <div class="details col-sm-8">
                      <div class="details-text">{{ client.name }}</div>
                      <!-- <div class="details-text" v-if="client.plan_test != 'unsubscribe'"><span>Date Subscribed</span>: {{client.suscribedDate}}</div>
                      <div class="details-text" v-if="client.plan_test == 'unsubscribe'"><span>Date Unsubscribed</span>: {{client.unsubscribedDate}}</div>
                      <div class="details-text">Number of Active Users: {{client.totalActiveUsers}}</div>
                      <div class="details-text"><span>Last Date Active</span>: {{client.lastActiveDate}}</div> -->
                    </div>
                  </router-link>
                </div>
              </div>
            </div>
            </div>
        </div>
    </div>
</template>
<script>
    import SecureImg from '../../components/SecureImg.vue';

    export default {
        name: 'client-children',
        data () {
            return {
                searchSelectedValueReactive: 'All Children',
                loading: true,
                children: [],
                client: {
                    name: null,
                    uniq_id: null
                },
                searchFilter: null
            }
        },
        created () {
            this.uniq_id = this.$route.params.uniq_id;

            let routes     = Api.getRoutes('webapp-client');

            routes.client.get(this.uniq_id).then((client) => {
                this.client   = client;
                this.children = client.children;
                this.loading = false;
            });
        },
        computed: {
            searchSelectedValue: function () {
                return this.searchSelectedValueReactive;
            },
            computedClients: function () {

                if (! this.children.length) {
                    return;
                }

                let ret = [];

                for (let i = 0; i < this.children.length; i++) {
                    let child = this.children[i];
                    ret.push(child);
                }

                ret = _.sortBy(ret, 'name');

                if (this.searchFilter === null) {
                    return ret;
                }

                let found = _.filter(ret, function(o) {
                    return this.isStatus(o.status) && this.isMatch(o.name);
                }.bind(this));

                return found;
            }
        },
        methods: {
            isMatch(name) {
                return name.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
            },
            isStatus(status) {
                let activeStatus = this.searchSelectedValue.toLowerCase();
                if (activeStatus != 'active' && activeStatus != 'inactive') {
                    return true; // All
                }

                return activeStatus == status;
            },
            setSearchSelectedValue: function (val) {
                this.searchSelectedValueReactive = val.srcElement.innerText;
            }
        },
        components: {
            SecureImg
        }
    }
</script>
<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
        button.btn-spaced {
            margin-top: 5px ;
            margin-bottom: 5px ;
        }

        ul {
            margin: 0;
            padding: 0;
            list-style-type: none;

            li {
                color: $list-element-major-font-color;
                background-color: $list-element-major-bg;

                border: 1px solid transparent;
                border-color: $list-element-major-border;
                border-radius: $general-border-radius;

                padding: 17px;
                margin: 10px 0;
            }

            li:hover {
                background-color: $list-element-major-hover-bg;
                border-color: $list-element-major-hover-border;

            }
        }
</style>
