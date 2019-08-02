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
                </h4>

                <user-detail v-if="computedUser"
                    v-model="computedUser"
                    :role-options="roleOptions"
                    :expanded="true"
                    :edit_mode="false">
                </user-detail>

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
    import UserDetail from '../../UserDetail.vue';

    export default {
        name: 'report-template-rpt-402',
        data () {
            return {
                Perm: Perm,
                loading: true,
                roleOptions: [],
                user: {
                    uniq_id: null,
                },
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
                'showProjects': false,
                'showClients': true,
                'showDates': false,
                'showSavePdf': true,
                'required': ['user','client'],
            });
        },
        props: {
            report: {
                type: Object,
                default: null
            },
        },
        computed: {
            reportData: function ()
            {
                return this.$store.state.reports.reportData;
            },
            computedUser: function ()
            {
                if (typeof this.$store.state.reports.reportData.reportData === 'undefined') {
                    return null;
                }

                if (this.$store.state.reports.reportData.reportData === null) {
                    return null;
                }

                if (typeof this.$store.state.reports.reportData.reportData.rows === 'undefined') {
                    return null;
                }

                if (!this.$store.state.reports.reportData.reportData.rows.length) {
                    return null;
                }

                return this.$store.state.reports.reportData.reportData.rows[0];
            }
        },
        components: {
            UserDetail
        },
        methods: {
            ...mapActions([
                'setReportOptions'
            ]),
        }
    }
</script>
