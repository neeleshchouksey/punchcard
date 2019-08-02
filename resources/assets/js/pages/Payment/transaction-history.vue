<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    .report {
        box-shadow: $main-box-shadow;
        transition: $box-shadow-transition;
        color: $list-element-major-font-color;
        background-color: $theme-light-gray;
        flex-grow: 1;
        padding: 17px;
        margin: 20px;
        min-height: 55px;
    }
    .report:hover {
        background-color: lighten($theme-light-gray, 5%);
        box-shadow: $main-box-shadow-hover;
        * {
            text-decoration: none;
        }
    }
</style>
<template>
<div>
  <div class="row transactionData">
    <div class="major-section-header-row">
      <h2>Past Billing
                    <span style="font-size: 70%" v-if="loading">(Loading ...)</span>
                </h2>

                <button @click="exportPdf" class="btn material">Export in PDF</button>
    </div>
    <hr>

    <div class="report row" v-if="!loading">

      <!-- <div class="col-sm-1">
        <div>Users</div>
      </div> -->
      <div class="col-sm-3">
        <div>Version</div>
      </div>
      <div class="col-sm-1">
        <div>Total Unique Punches</div>
      </div>
      <div class="col-sm-1">
        <div>Cost Per Punch</div>
      </div>
      <div class="col-sm-1">
        <div>Amount</div>
      </div>

      <div class="col-sm-2">
        <div>Transaction Date</div>
      </div>
      <div class="col-sm-4">
        <div>Billing Cycle</div>
      </div>
      <!-- <div class="col-sm-2">
        <div>Creation Time</div>
      </div> -->
    </div>

    <div class="report row" v-for="report in computedReports">

      <!-- <div class="col-sm-1">
        {{ report.user_id }}
      </div> -->
      <div class="col-sm-3">
        {{ report.version }}
      </div>
      <div class="col-sm-1">
        {{ report.total_punch }}
      </div>
      <div class="col-sm-1">
        {{ report.per_punch_cost }}
      </div>
      <div class="col-sm-1">
        {{ report.txn_amount }}
      </div>
      <div class="col-sm-2">
        {{ report.billing_start_date }}
      </div>
      <div class="col-sm-4">
        <!-- {{ report.next_billing_date }} -->
        {{report.billing_start_date}} through {{report.billing_end_date}}
      </div>
      <!-- <div class="col-sm-2">
        {{ report.billing_end_date }}
      </div>
      <div class="col-sm-2">
        {{ report.create_time }}
      </div> -->
    </div>
  </div>
</div>
</template>
<script>
import UX from '../../helpers/UX';
let formatHelper = require ('../../helpers/format.js').defaultss
export default {
  name: 'transaction-history',
  data() {
    return {
      loading: true,
      reports: [{
          txn_amount: '',
          version: '',
          total_punch: '',
          per_punch_cost: '',
          txn_amount: '',
          billing_start_date: '',
          billing_end_date: '',
          create_time: '',
        },
      ]
    }
  },
  created() {
    this.$store.dispatch('getAllTransaction').then((response) => {
      this.loading = false;
      this.reports = response.body.data;
      for (var i = 0; i < this.reports.length; i++) {
        this.reports[i].billing_start_date =Moment(new Date(this.reports[i].billing_start_date)).format("DD/MM/YYYY");
        this.reports[i].billing_end_date =Moment(new Date(this.reports[i].billing_end_date)).format("DD/MM/YYYY");
        this.reports[i].create_time =Moment(new Date(this.reports[i].create_time)).format("DD/MM/YYYY");
      }
    });
  },
  methods: {
    exportPdf: function () {
        let routes = Api.getRoutes('webapp-payments');
        return routes.export.pdf().then((response) => {
            var headers = response.headers;
            let blob = new Blob([response.data],{type:headers.get('content-type')});
            let link = document.createElement('a');
            let filename = "transactionHistory.pdf";
            link.href = window.URL.createObjectURL(blob);
            link.download = filename;
            link.click();
        }).catch((result) => {
        });
    },

  },
  computed: {
    computedReports: function() {

      if (!this.reports.length) {
        return;
      }

      let filteredReports = this.reports;

      return filteredReports;

      // Enable if need to filter

      let found = _.filter(filteredReports, function(o) {
        return this.isStatus(o.status) && this.isMatch(o);
      }.bind(this));

      this.loading = false;
      return found;
    }
  }
}
</script>
