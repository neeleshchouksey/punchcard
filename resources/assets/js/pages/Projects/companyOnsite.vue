<style lang="sass" scoped>
  @import '../../../sass/_variables.scss';

  .row.profile-item {
      display: flex;
      align-items: center;
      text-align: right;
  }
  .date-range-section {
      display: flex;
      align-items: center;
      span {
          margin: 0 15px;
      }
  }
  .options-row {
      display: flex;
      align-items: center;
  }

  .boundaries {
      box-shadow: $main-box-shadow;
      transition: $box-shadow-transition;
      color: $list-element-major-font-color;
      background-color: $theme-light-gray;
      flex-grow: 1;
      padding: 17px;
      margin: 20px;
  }
    .select-data {
        margin: auto;
        margin-top: 25px;
        text-align: center;
    }
</style>

<template>
    <div>
        <h1>Project: {{ project.name }}</h1>
        <div>
            <div class="row">
                <div class="col-sm-12" ref="dataDiv">
                  <div class="boundaries">
                      <loader :loading="loading" loading_msg="Loading Data..."></loader>
                      <div v-show="!loading">
                          <h1>Companies On Site</h1>
                          <div class="reportData">
                              <h4>
                                  (Today’s Date) {{currentDate()}}
                              </h4>
                              <table class="table table-striped" style="border-radius: 15px;">
                                  <thead>
                                      <tr>
                                          <td>Company Name</td>
                                          <td>Number Of Employees</td>
                                          <td>View Employees</td>
                                     </tr>
                                  </thead>
                                  <tbody>
                                      <tr v-for="company in companiesOnsite">
                                        <td>{{company.name}}</td>
                                        <td>{{company.user_count}}</td>
                                        <td v-html="company.timesheet"></td>
                                     </tr>
                                  </tbody>
                              </table>
                          </div>
                      </div>
                  </div>
                </div>
            </div>

            <!-- <div class="row" >
                <div class="col-sm-12">
                    <div>
                        <button @click="exportPdf" class="btn material">Export in PDF</button>
                        <button @click="exportExcel" class="btn material" download>Export in Excel</button>
                    </div>
                </div>
            </div> -->
        </div>
    </div>
</template>

<script>
    import UX from '../../helpers/UX';

    export default {
        name: 'company-on-site',
        data () {
            return {
              loading: true,
              project : {},
              companiesOnsite : []
            }
        },
        created () {
            this.loading = false;

            this.routes = Api.getRoutes('webapp-projects');
            this.project_id = this.$route.params.projectId;
            this.$store.dispatch('getProject', this.$route.params.projectId).then((project) => {
                this.project = project;
                // this.project.id
                this.$store.dispatch('getProjectCompanyOnSite', this.project.id).then((data) => {
                    this.companiesOnsite = data.data.data;
                    this.companiesOnsite = _.map(this.companiesOnsite, (row) => {
                        row.timesheet = '<a target="_blank" href="/projectEmployeesOnsite/' + this.project.uniq_id + '/'+row.uniq_id+'">View Employees </a>';
                        return row;
                    })
                    console.log("this.companiesOnsite:---------",this.companiesOnsite);
                });

                console.log("this.project",this.project);
            });
        },
        computed: {},
        methods:{
          currentDate : function(){
            return Moment().format('dddd DD/MM/YYYY');
          },
          exportPdf: function () {
              let data  = this.$store.state.reports.reportData;
              data.html = $('.reportData').html();

              let routes     = Api.getRoutes('webapp-reports');
              return routes.export.pdf(data).then((response) => {
                  var headers = response.headers;
                  let blob = new Blob([response.data],{type:headers.get('content-type')});
                  let link = document.createElement('a');
                  let filename = (response.headers.get('content-disposition') || '').split('filename=')[1];
                      filename = filename.replace(/"/g, '');
                  link.href = window.URL.createObjectURL(blob);
                  link.download = filename;
                  link.click(); // Downloads...
              }).catch((result) => {
              });
          },
          exportExcel: function () {
              let data  = this.$store.state.reports.reportData;
              data.rows = this.$store.state.reports.exportableReportData;
              let routes     = Api.getRoutes('webapp-reports');

              return routes.export.excel(data).then((response) => {
                  var headers = response.headers;

                  let blob = new Blob([response.data],{type:headers.get('content-type')});
                  let link = document.createElement('a');
                  let filename = (response.headers.get('content-disposition') || '').split('filename=')[1];
                      filename = filename.replace(/"/g, '');
                  link.href = window.URL.createObjectURL(blob);
                  link.download = filename;
                  link.click(); // Downloads...

              }).catch((result) => {
              });
          },
        }
    }
</script>
