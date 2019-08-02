<style lang="sass" scoped>
    @import '../../../../sass/_variables.scss';
    div {
        .select-data {
            margin: auto;
            margin-top: 25px;
            text-align: center;
        }
    }
</style>
<template>
    <div class="boundaries">
        <loader :loading="loading" loading_msg="Loading Report..."></loader>

        <div v-show="!loading">
            <h1>{{ report.report_number }}: {{ report.name }}</h1>
            <div class="reportData">
                <div class="row" v-if="reportData.formData">
                    <div class="col-sm-9">
                        <h4>
                            <div v-if="reportData.formData && reportData.formData.client">
                                Client: {{ reportData.formData.client.text }}
                            </div>
                            <div v-if="reportData.formData && reportData.formData.user">
                                User: {{ reportData.formData.user.text }}
                            </div>
                            <div v-if="reportData.formData && reportData.formData.project">
                                Project: {{ reportData.formData.project.text }}
                            </div>
                            <div v-if="reportData.formData && reportData.formData.startDate && reportData.formData.endDate">
                                Date Range: {{ reportData.formData.startDate}} - {{ reportData.formData.endDate}}
                            </div>
                        </h4>
                    </div>

                    <div class="col-sm-3" v-if="AddBackIn">
                        <toggle-switch
                            on-text="Show All" off-text="Show Late"
                            v-model="showOnlyLates"
                            v-on:input="toggleShowOnlyLates">
                        </toggle-switch>
                    </div>
                </div>
                <simple-table :rows="computedRows" :cols="computedColumns" v-if="computedRows"></simple-table>
                <div v-else class="select-data">
                    <h3>Please select data above to create report</h3>
                </div>

            </div>
        </div>

<pre v-if="DISABLED">
{{ showOnlyLates }}
{{ reportData }}
{{ report }}
</pre>
    </div>
</template>
<script>
    import { mapActions } from 'vuex'
    import SimpleTable from '../../SimpleTable.vue';
    import ToggleSwitch from '../../ToggleSwitch.vue';
    let formatHelper = require ('../../../helpers/format.js').default

    export default {
        name: 'report-template-rpt-403',
        data () {
            return {
                Perm: Perm,
                loading: true,
                showOnlyLates: false,
                initReportData: {
                    formData: {
                        user: {
                            text: null
                        },
                        project: {
                            text: null
                        }
                    }
                }
            }
        },
        created () {
            this.loading = false

            this.setReportOptions({
                'showUsers': true,
                'showProjects': true,
                'showDates': true,
                'showClients': true,
                'required': ['user', 'project','client'],
            });
        },
        props: {
            report: {
                type: Object,
                default: null
            },
        },
        computed: {
            computedColumns: function ()
            {
                if (typeof this.reportData.reportData === 'undefined') {
                    return;
                }

                if (typeof this.reportData.reportData.columns === 'undefined') {
                    return;
                }

                return this.reportData.reportData.columns
            },
            computedRows: function ()
            {
                if (typeof this.reportData.reportData === 'undefined') {
                    return;
                }

                if (typeof this.reportData.reportData.rows === 'undefined') {
                    return;
                }


                let exportableReportData = _.map(this.reportData.reportData.rows, (row) => {
                    // console.log(row);
                    row[7] = '<a target="_blank" href="/user/' + row[0] + '/timesheets">View Timesheet</a>';
                    return row;
                });

                this.$store.dispatch('setExportableReportData', exportableReportData);
                return exportableReportData;
            },
            reportData: function ()
            {
                return this.$store.state.reports.reportData;
            },
        },
        components: {
            SimpleTable,
            ToggleSwitch
        },
        methods: {
            ...mapActions([
                'setReportOptions'
            ]),
            toggleShowOnlyLates: function() {
                this.showOnlyLates = !this.showOnlyLates;
            }
        }
    }
</script>
