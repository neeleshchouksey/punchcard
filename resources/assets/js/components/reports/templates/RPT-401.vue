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

                <simple-table :rows="computedRows" :cols="computedColumns" v-if="computedRows"></simple-table>
                <div v-else class="select-data">
                    <h3>Please select data above to create report</h3>
                </div>

            </div>
        </div>

<pre v-if="DISABLED">
{{ reportData }}
{{ report }}
</pre>
    </div>
</template>
<script>
    import { mapActions } from 'vuex'
    import SimpleTable from '../../SimpleTable.vue';
    let formatHelper = require ('../../../helpers/format.js').default

    export default {
        name: 'report-template-rpt-401',
        data () {
            return {
                Perm: Perm,
                loading: true,
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
                'required': ['user', 'project'],
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

                //let exportableReportData = this.reportData.reportData.rows;

                let popped   = this.reportData.reportData.rows.pop();
                let filtered = _.map(this.reportData.reportData.rows, (row) => {
                    return [
                        row[1],
                        formatHelper.date(row[0], 'hh:mm a'),
                        formatHelper.date(row[2], 'hh:mm a'),
                        row[3]
                    ];
                });

                filtered.push(popped);

                this.$store.dispatch('setExportableReportData', filtered);
                return filtered;

                //this.$store.dispatch('setExportableReportData', exportableReportData);
                //return exportableReportData;
            },
            reportData: function ()
            {
                return this.$store.state.reports.reportData;
            },
        },
        components: {
            SimpleTable
        },
        methods: {
            ...mapActions([
                'setReportOptions'
            ]),
        }
    }
</script>
