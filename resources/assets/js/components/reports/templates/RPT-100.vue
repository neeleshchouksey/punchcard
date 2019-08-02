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
    <div>

        <loader :loading="loading" loading_msg="Loading Report..."></loader>

        <div v-show="!loading">
            <h1>{{ report.report_number }}: {{ report.name }}</h1>
            <div class="reportData">
                <h4>
                    <div v-if="reportData.formData && reportData.formData.client">
                        Client: {{ reportData.formData.client.text }}
                    </div>
                    <div v-if="reportData.formData && reportData.formData.startDate && reportData.formData.endDate">
                        Date Range: {{ reportData.formData.startDate}} - {{ reportData.formData.endDate}}
                    </div>
                </h4>

                <div  v-if="computedRows">
                    <simple-table :rows="computedRows" :cols="computedColumns"></simple-table>
                </div>
                <div v-else>
                    <h3>Choose a date range and click Update to generate the report.</h3>
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

    export default {
        name: 'report-template-rpt-100',
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
                'showClients': true,
                'showDates': true,
                'required': ['client'],
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

                    let link = '<a target="_blank" href="/child/' + row[5] + '/summary">Client Detail</a>';
                    row[5] = link
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
            SimpleTable
        },
        methods: {
            ...mapActions([
                'setReportOptions'
            ]),
        }
    }
</script>
