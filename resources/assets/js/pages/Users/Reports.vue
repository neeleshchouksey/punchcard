<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

        .report {
            color: $list-element-major-font-color;
            background-color: $list-element-major-bg;

            border: 1px solid transparent;
            border-color: $list-element-major-border;
            border-radius: $general-border-radius;

            padding: 17px;
            margin: 10px 0;
        }

    }
</style>
<template>
    <div>
        <h3>Reports</h3>

        <p>
            If you don't make any selections for report permissions, the default will be used for that user.
        </p>

        <div>
            <div class="report row" v-for="report in computedReports">
                <div class="col-sm-3">
                    {{ report.report_number }}
                </div>
                <div class="col-sm-6">
                    {{ report.name }}
                </div>
                <div class="col-sm-3">
                    <toggle-switch
                        v-on:input="toggleAccess(report)"
                        on-text="Enabled"
                        :off-text="defaultOffText"
                        v-model="report.hasReportAccess">
                    </toggle-switch>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import { mapActions } from 'vuex'
    import ToggleSwitch from '../../components/ToggleSwitch.vue';

    export default {
        name: 'user-reports',
        data () {
            return {
                atLeastOneReportAccess: false,
                reports: [
                    {
                        report_number: '',
                        name: 'Checking...',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                ],
                user: {
                    permissions: {},
                },
            }
        },
        created () {
            this.uniq_id = this.$route.params.user_id;

            let routes     = Api.getRoutes('user-admin');
            routes.user.get(this.uniq_id).then((user) => {
                this.user = user;
            });

            this.$store.dispatch('getAllReports').then((reports) => {
                this.reports = reports;
            });
        },
        props: {
        },
        computed: {
            defaultOffText() {
                return this.atLeastOneReportAccess ? 'Disabled' : 'Default';
            },

            computedReports: function () {

                if (! this.reports.length) {
                    return;
                }

                this.atLeastOneReportAccess = false;
                let filteredReports = _.filter(this.reports,  report => {
                    report.hasReportAccess = (_.indexOf(this.user.permissions.reports, report.id) > -1);
                    if (report.hasReportAccess) {
                        this.atLeastOneReportAccess = true;
                    }
                    return report;
                });

                return filteredReports;
            }
        },
        components: {
            ToggleSwitch
        },
        methods: {
            ...mapActions([
                'toggleReportAccess'
            ]),
            toggleAccess(report) {
                this.toggleReportAccess([this.user, report]).then((result) => {
                    if (result.response.status == 200) {

                    }
                });
            },
        }
    }
</script>
