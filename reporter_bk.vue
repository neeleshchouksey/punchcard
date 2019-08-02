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


</style>
<template>
    <div>
        <h1>{{ report_name }}</h1>

        <div class="row options-row" ref="reportOptions">
            <div v-if="atLeastOneDropdownOption" class="col-sm-5">
                <form-dropdown :edit_mode="true"
                    v-on:option-changed="clientSelectChanged"
                    v-model="clientQueryParam"
                    :options="clientOptions" v-if="clientOptions">
                    Clients
                </form-dropdown>
                <form-dropdown :edit_mode="true"
                    v-on:option-changed="projectSelectChanged"
                    v-model="projectQueryParam"
                    :options="projectOptions" v-if="projectOptions">
                    Projects
                </form-dropdown>
                <form-dropdown :edit_mode="true"
                    v-on:option-changed="userSelectChanged"
                    v-model="userQueryParam"
                    :options="userOptions" v-if="userOptions">
                    Users
                </form-dropdown>
            </div>
            <div v-else>
                <div v-if="options.showDates">
                    Choose a date range:
                </div>
            </div>
            <div class="col-sm-7" v-if="options.showDates">
                <div class="row" v-if="$route.query.run && DISABLED">
                    <div class="col-sm-12">
                        <button @click="updateSubReport" class="btn">Click Update to build this report</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 date-range-section">
                        <inverse-date-picker
                            v-if="allData.startDate"
                            v-model="allData.startDate"
                            :show-clear="false"
                            format="YYYY-MM-DD"
                            placeholder="Choose start date">
                        </inverse-date-picker>
                        <span> to </span>
                        <inverse-date-picker
                            v-if="allData.endDate"
                            v-model="allData.endDate"
                            :show-clear="false"
                            format="YYYY-MM-DD"
                            placeholder="Choose end date">
                        </inverse-date-picker>
                        <button @click="updateSubReport" class="btn">Update</button>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="reportLoaded" v-on:subReportLoad="subReportLoaded()">

            <div class="row">
                <div class="col-sm-12" ref="dataDiv">
                    <slot></slot>
                </div>
            </div>

            <div class="row" v-if="rowsExist">
                <div class="col-sm-12">
                    <div v-if="showSavePdf">
                        <button class="btn material" @click="printPdf">Print to Save PDF</button>
                    </div>
                    <div v-else>
                        <button @click="exportPdf" class="btn material">Export in PDF</button>
                        <button @click="exportExcel" class="btn material" download>Export in Excel</button>
                    </div>
                </div>
            </div>
        </div>
<pre v-if="DISABLED">
{{ allData }}
</pre>
    </div>
</template>
<script>
    import UX from '../../helpers/UX';
    import formatHelper from '../../helpers/format';
    import { mapActions } from 'vuex'
    import FormDropdown from '../FormSelect.vue';
    import InverseDatePicker from '../DatePicker.vue'

    export default {
        name: 'reporter',
        data () {
            return {
                chosenClient: null,
                allData: {
                    report_uniq_id: null,
                    user: null,
                    project: null,
                    client: {
                        value: User.profile().client.uniq_id,
                         text: User.profile().client.name
                    },
                    startDate: null,
                    endDate: null
                },
                Perm: Perm,
                /*reportOptionData: {
                    users: [],
                    projects: [],
                    clients: []
                }*/
            }
        },
        created () {
            //
            // Clear it, if there was anything
            //
            this.clearReportData();
            this.uniq_id = this.$route.params.uniq_id;

            this.allData.startDate = this.defaultStartDate();
            this.allData.endDate   = this.defaultEndDate();

            this.$store.dispatch('getReportOptionData', this.uniq_id).then((reportOptionData) => {
                this.$store.dispatch('loading', false);

            });
        },
        props: {
            report: {
                type: Object,
                default: function () {
                    return {
                        name: null,
                        report_number: null
                    }
                }
            },
        },
        computed: {
            reportOptionData()
            {
                return this.$store.state.report_option_data.reportData;
            },

            showSavePdf()
            {
                return this.options.showSavePdf;
            },

            rowsExist()
            {
                if (typeof this.$store.state.reports === 'undefined') {
                    return false;
                }

                if (typeof this.$store.state.reports.reportData === 'undefined') {
                    return false;
                }

                if (typeof this.$store.state.reports.reportData.reportData === 'undefined') {
                    return false;
                }

                if (typeof this.$store.state.reports.reportData.reportData.rows === 'undefined') {
                    return false;
                }

                return this.$store.state.reports.reportData.reportData.rows.length > 0;
            },
            options: function ()
            {
                return this.$store.state.report_option_data.reportOptions;
            },
            reportLoaded: function ()
            {
                return true;
            },

            userQueryParam: function ()
            {
                if (typeof this.$route.query.user === 'undefined') {
                    return null;
                }

                return this.$route.query.user;
            },

            userOptions: function ()
            {
                if (! this.options.showUsers) {
                    return;
                }

                if (typeof this.reportOptionData.users === 'undefined') {
                    return;
                }

                if (! this.reportOptionData.users.length) {
                    return;
                }

                let mapped = _.map(this.reportOptionData.users, function(o) {
                    return {"value": o.uniq_id, "text": o.name}
                });

                return mapped;
            },

            atLeastOneDropdownOption()
            {
                return this.clientOptions || this.userOptions || this.projectOptions;
            },

            clientQueryParam()
            {
                if (typeof this.$route.query.client === 'undefined') {
                    return null;
                }

                return this.$route.query.client;
            },

            clientOptions: function ()
            {
                if (! this.options.showClients) {
                    return;
                }

                if (typeof this.reportOptionData.clients === 'undefined') {
                    return;
                }

                if (! this.reportOptionData.clients.length) {
                    return;
                }

                let mapped = _.map(this.reportOptionData.clients, function(o) {
                    return {"value": o.uniq_id, "text": o.name}
                });

                return mapped;
            },
            projectQueryParam: function ()
            {
              console.log("this.$route.query************", this.$route.query);
                if (typeof this.$route.query.project === 'undefined') {
                    return null;
                }

                return this.$route.query.project
            },
            projectOptions: function ()
            {
                if (! this.options.showProjects) {
                    return;
                }

                if (typeof this.reportOptionData.projects === 'undefined') {
                    return;
                }

                if (! this.reportOptionData.projects.length) {
                    return;
                }

                let chosenClient = this.chosenClient;

                let filtered = _.filter(this.reportOptionData.projects, function(o) {
                    let client_uniq_id;

                    if (typeof o.client_uniq_id !== 'undefined') {
                        client_uniq_id = o.client_uniq_id;
                    } else {
                        client_uniq_id = null;
                    }

                    if (chosenClient === null || client_uniq_id === null) {
                        return true;
                    }

                    if (chosenClient.value == client_uniq_id) {
                        return true;
                    }
                });

                let mapped = _.map(filtered, function(o) {
                    return {"value": o.uniq_id, "text": o.name};
                });

                return mapped;
            }
        },
        components: {
            FormDropdown,
            InverseDatePicker
        },

        methods: {
            printPdf()
            {
                window.print();
            },

            ...mapActions([
                'passSubReportData',
                'clearReportData'
            ]),
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
                    let filename = (response.headers.get('content-disposition') || '').split('filename=')[1];//palash code
                        filename = filename.replace(/"/g, '');
                    link.href = window.URL.createObjectURL(blob);
                    link.download = filename;
                    link.click(); // Downloads...

                }).catch((result) => {
                });
            },

            clientSelectChanged: function (data) {
                this.chosenClient = data;

                this.allData.client = data;
                this.reportDataChanged();
            },

            projectSelectChanged: function (data) {
                this.allData.project = data;
                this.reportDataChanged();
            },

            userSelectChanged: function (data) {
                this.allData.user = data;
                this.reportDataChanged();
            },

            reportDataChanged: function ()
            {
                this.allData.required = this.options.required
                this.allData.report_uniq_id = this.report.uniq_id
                this.$store.dispatch('loading', true);
                return this.passSubReportData(this.allData);
            },

            updateSubReport: function (e)
            {
                let event = e;

                if (UX.alreadyClicked(event)) {
                    return
                }

                let originalText = $(event.target).text();
                $(event.target).text('Updating...');

                UX.setTarget(event)
                  .addClicked();

                this.reportDataChanged().then(result => {

                    $(event.target).text(originalText);

                    UX.setTarget(event)
                      .removeClicked();

                });
            },
            defaultStartDate: function ()
            {
                //return Moment().subtract(14, 'days').format('YYYY-MM-DD');
                return formatHelper.date(Moment().subtract(14, 'days'), 'YYYY-MM-DD');
            },
            defaultEndDate: function ()
            {
                //return Moment().add(1, 'day').format('YYYY-MM-DD');
                return formatHelper.date(Moment().add(1, 'day'), 'YYYY-MM-DD');
            },
        }
    }
</script>
