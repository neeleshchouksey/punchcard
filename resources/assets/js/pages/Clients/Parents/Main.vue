<style lang="sass" scoped>
    @import '../../../../sass/_variables.scss';
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

            div {
                min-height: 50px;
            }
        }
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
</style>
<template>
<div>
  <h1>Parent Companies</h1>

  <loader :loading="loading" loading_msg="Loading ..."></loader>

  <router-link v-if="!loading" :to="{name: 'parents-new'}">
    <button type="button" class="btn-spaced btn btn-default">Add Parent Company</button>
  </router-link>

  <div v-if="computedClients">
    <div class="input-group">
      <input type="text" class="form-control" aria-label="search" placeholder="Search for..." v-model="searchFilter">
      <div class="input-group-btn">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span>{{ searchSelectedValue }}</span> <span class="caret"></span>
                        </button>

        <input type="hidden" v-model="searchSelectedValue" />
        <ul class="dropdown-menu dropdown-menu-left dd-filter">
          <li @click="setSearchSelectedValue">All</li>
          <li @click="setSearchSelectedValue">Active</li>
          <li @click="setSearchSelectedValue">Inactive</li>
        </ul>
      </div>

      <!-- <button style="width: 101px;margin-left: 16px;" v-if="!listView" @click="listView = !listView">List</button>
                    <button style="width: 101px;margin-left: 16px;" v-if="listView" @click="listView = !listView">Grid</button> -->
    </div>

    <div v-if="listView" class="row">
      <div class="col-sm-6" v-for="client in computedClients">
        <div class="content-box">
          <div class="row content-section">
            <router-link v-if="client.uniq_id" :to="{name: 'child-summary', params: {uniq_id: client.uniq_id}}">
              <div class="image col-sm-4">
                <secure-img :src="client.logo" className="size-125 img-rounded img-responsive" title=""></secure-img>
              </div>
              <div class="details col-sm-8">
                <div class="details-text">{{ client.name }}</div>
                <div class="details-text" v-if="client.plan_test != 'unsubscribe'"><span>Date Subscribed</span>: {{client.suscribedDate}}</div>
                <div class="details-text" v-if="client.plan_test == 'unsubscribe'"><span>Date Unsubscribed</span>: {{client.unsubscribedDate}}</div>
                <div class="details-text">Number of Active Users: {{client.totalActiveUsers}}</div>
                <div class="details-text"><span>Last Date Active</span>: {{client.lastActiveDate}}</div>
              </div>
            </router-link>
          </div>
        </div>
      </div>
    </div>

    <!-- <ul v-if="listView">
                  <li v-for="client in computedClients">
                        <div class="row">
                    <router-link v-if="client.uniq_id" :to="{name: 'child-summary', params: {uniq_id: client.uniq_id}}">
                            <div class="image col-sm-3">
                                <secure-img :src="client.logo" className="img-rounded img-responsive" title=""></secure-img>
                            </div>
                            <div class="details col-sm-9">
                                <h2>
                                    {{ client.name }}
                                </h2>
                            </div>
                    </router-link>
                        </div>
                  </li>
                </ul> -->

    <div v-if="!listView" class="row">
      <div class="col-sm-4" v-for="client in computedClients">
        <router-link v-if="client.uniq_id" :to="{name: 'child-summary', params: {uniq_id: client.uniq_id}}">
          <div class="image">
            <secure-img :src="client.logo" className="img-rounded img-responsive" title=""></secure-img>
          </div>
          <div class="details" style="text-align: center;">
            <h2>
                              {{ client.name }}
                          </h2>
          </div>
        </router-link>

      </div>
    </div>
  </div>
</div>
</template>
<script>
import SecureImg from '../../../components/SecureImg.vue';

export default {
  name: 'parent-main',
  data() {
    return {
      Perm: Perm,
      listView: true,
      loading: true,
      clients: [{
          name: '',
          status: '',
          uniq_id: null,
        },
        {
          name: '',
          status: '',
          uniq_id: null,
        },
        {
          name: '',
          status: '',
          uniq_id: null,
        },
        {
          name: '',
          status: '',
          uniq_id: null,
        }
      ],
      searchFilter: '',
      searchSelectedValueReactive: 'active',
    }
  },
  created() {
    let routes = Api.getRoutes('webapp-client');

    routes.client.get(null).then((clients) => {
      console.log("clients: *****************", clients)

      this.clients = _.orderBy(clients, 'name');
      // this.clients   = _.sortBy(clients, function(o) { return o.name; });
      console.log("this.clients: *****************", this.clients)
      this.loading = false;
    });
  },
  props: {
    value: {
      type: String,
      default: null
    },
  },
  computed: {
    searchSelectedValue: function() {
      return this.searchSelectedValueReactive;
    },
    computedClients: function() {

      if (!this.clients.length) {
        return;
      }

      let found = _.filter(this.clients, function(o) {
        return this.isStatus(o.status) && this.isMatch(o.name);
      }.bind(this));

      return found;
    }
  },
  components: {
    SecureImg
  },
  methods: {
    isMatch(name) {
      if (name === null) {
        return true;
      }

      return name.toLowerCase().indexOf(this.searchFilter.toLowerCase()) > -1;
    },
    isStatus(status) {
      let activeStatus = this.searchSelectedValue.toLowerCase();
      if (activeStatus != 'active' && activeStatus != 'inactive') {
        return true; // All
      }

      return activeStatus == status;
    },
    setSearchSelectedValue: function(val) {
      this.searchSelectedValueReactive = val.srcElement.innerText;
    }
  }
}
</script>
