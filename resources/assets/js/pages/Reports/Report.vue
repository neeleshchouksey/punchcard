<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
</style>
<template>
    <div>
        <reporter :report="report">
            <component :is="reportTemplate" :loading="loading" :report="report"></component>
        </reporter>
    </div>
</template>
<script>
    import Reporter from '../../components/reports/Reporter.vue'
    import RPT100 from '../../components/reports/templates/RPT-100.vue'
    import RPT101 from '../../components/reports/templates/RPT-101.vue'
    import RPT200 from '../../components/reports/templates/RPT-200.vue'
    import RPT201 from '../../components/reports/templates/RPT-201.vue'
    import RPT300 from '../../components/reports/templates/RPT-300.vue'
    import RPT301 from '../../components/reports/templates/RPT-301.vue'
    import RPT302 from '../../components/reports/templates/RPT-302.vue'
    import RPT303 from '../../components/reports/templates/RPT-303.vue'
    import RPT304 from '../../components/reports/templates/RPT-304.vue'
    import RPT400 from '../../components/reports/templates/RPT-400.vue'
    import RPT401 from '../../components/reports/templates/RPT-401.vue'
    import RPT402 from '../../components/reports/templates/RPT-402.vue'
    import RPT403 from '../../components/reports/templates/RPT-403.vue'
    import RPT404 from '../../components/reports/templates/RPT-404.vue'
    import RPT405 from '../../components/reports/templates/RPT-405.vue'
    import RPT500 from '../../components/reports/templates/RPT-500.vue'
    import RPT501 from '../../components/reports/templates/RPT-501.vue'
    import RPT600 from '../../components/reports/templates/RPT-600.vue'
    import RPT601 from '../../components/reports/templates/RPT-601.vue'
    import RPT602 from '../../components/reports/templates/RPT-602.vue'
    import RPT603 from '../../components/reports/templates/RPT-603.vue'
    import RPT604 from '../../components/reports/templates/RPT-604.vue'
    import RPT605 from '../../components/reports/templates/RPT-605.vue'
    import RPT606 from '../../components/reports/templates/RPT-606.vue'

    export default {
        name: 'reports-main',

        data () {
            return {
                uniq_id: this.$route.params.uniq_id,
                report: {
                    name: 'Loading...',
                    report_number: null
                },
            }
        },
        created () {
            this.$store.dispatch('loading', true);
            this.$store.dispatch('getReport', this.uniq_id).then((report) => {
                this.$store.dispatch('loading', false);

                if (report != null) {
                    this.report  = report;
                } else {
                    this.$store.dispatch('showAlertFail', {title: 'Unable to load report data'});
                }
            });
        },
        computed: {
            reportTemplate() {
                return this.report.report_number;
            },
            loading() {
                return this.$store.state.loading;
            },
        },
        methods: {
            reEmit: function(data)
            {
                this.$emit('subReportLoad', data)
            }
        },
        components: {
            Reporter,
            RPT100,
            RPT101,
            RPT200,
            RPT201,
            RPT300,
            RPT301,
            RPT302,
            RPT303,
            RPT304,
            RPT400,
            RPT401,
            RPT402,
            RPT403,
            RPT404,
            RPT405,
            RPT500,
            RPT501,
            RPT600,
            RPT601,
            RPT602,
            RPT603,
            RPT604,
            RPT605,
            RPT606
        }
    }
</script>
