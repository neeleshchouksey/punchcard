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

        <h1>{{ report.report_number }}: {{ report.name }}</h1>

        <div class="reportData">
            <h4>
                <div v-if="reportData.formData && reportData.formData.client">
                        Client: {{ reportData.formData.client.text }}
                </div>
                <div v-if="reportData.formData && reportData.formData.user">
                    User: {{ reportData.formData.user.text }}
                </div>
                <div v-if="report.name">
                    Project: {{ report.name }}
                </div>
                <div v-if="reportData.formData && reportData.formData.startDate && reportData.formData.endDate">
                    Date Range: {{ reportData.formData.startDate}} - {{ reportData.formData.endDate}}
                </div>
            </h4>

            <div v-if="!loading">
                <simple-table :rows="computedRows" :cols="computedColumns" v-if="computedRows"></simple-table>
                <div v-else class="select-data">
                    <h3>Please select data above to create report</h3>
                </div>
            </div>
            <div v-else>
                <loader :loading="loading" loading_msg="Loading Data..."></loader>
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
        name: 'report-template-rpt-404',
        data () {
            return {
                Perm: Perm,
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
            this.setReportOptions({
                'showProjects': true,
                'showDates': true,
                'showUsers': true,
                'showClients': true,
                'required': ['user', 'project','client'],
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

                let exportableReportData = _.filter(this.reportData.reportData.rows, (row) => {
                    //row.name = '<router-link :to="">' + row.name + '</router-link>';
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
