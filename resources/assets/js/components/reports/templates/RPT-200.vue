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
                    <div v-if="report.name">
                        Project: {{ report.name }}
                    </div>
                    <div v-if="reportData.formData && reportData.formData.startDate && reportData.formData.endDate">
                        Date Range: {{ reportData.formData.startDate}} - {{ reportData.formData.endDate}}
                    </div>
                </h4>

                <simple-table :rows="computedRows" :cols="computedColumns" v-if="computedRows"></simple-table>

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
        name: 'report-template-rpt-200',
        data () {
            return {
                Perm: Perm,
                loading: true,
                initReportData: {
                    formData: {
                        user: {
                            text: null
                        },
                        client: {
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
                'showUsers': false,
                'showClients': true,
                'showProjects': true,
                'showDates': true,
                'required': ['client', 'project'],
            });
        },
        props: {
            report: {
                type: Object,
                default: null
            },
            loading: {
                type: Boolean,
                default: false
            }
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
                    let link = '<a target="_blank" href="/child/' + row[0] + '/employees">List Employees</a>';
                    row[1] = '<a target="_blank" href="/child/' + row[0] + '/employees">'+row[1]+'</a>';
                    row[4] = link
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
