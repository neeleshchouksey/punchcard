<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    .report {
        box-shadow: $main-box-shadow;
        transition: $box-shadow-transition;
        color: $list-element-major-font-color;
        background-color: $theme-light-gray;
        flex-grow: 1;
        padding: 17px;
        margin: 20px;
        min-height: 55px;
    }
    .report:hover {
        background-color: lighten($theme-light-gray, 5%);
        box-shadow: $main-box-shadow-hover;
        * {
            text-decoration: none;
        }
    }
</style>
<template>
    <div>

        <!-- <div class="row">
            <button @click="bulkExport" v-permission="'ShowReportsBulkExport'" class="primary-button btn">
                Bulk Export
            </button>
        </div> -->

        <div class="row">
            <div class="major-section-header-row">
                <h2>Reports
                    <span style="font-size: 70%" v-if="loading">(Loading ...)</span>
                </h2>
            </div>
            <hr>
            <div class="report row" v-for="report in computedReports">
                <router-link :to="{ path: '/report/' + report.uniq_id + '', meta: {}}">
                        <div class="col-sm-3">
                            {{ report.report_number }}
                        </div>
                        <div class="col-sm-9">
                            {{ report.name }}
                        </div>
                </router-link>
            </div>
        </div>
    </div>
</template>
<script>
    import UX from '../../helpers/UX';

    export default {
        name: 'reports',
        data () {
            return {
                loading: true,
                reports: [
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                    {
                        report_number: '',
                        name: '',
                    },
                ]
            }
        },
        created () {
            this.$store.dispatch('getReports').then((reports) => {
               this.loading = false;
               this.reports = reports;
            });
        },
        methods: {
            bulkExport(event) {

                if (UX.alreadyClicked(event)) {
                    return;
                }

                UX.setTarget(event)
                  .addClicked()
                  .replaceWithSpin('Exporting, please wait');

                let routes     = Api.getRoutes('webapp-reports');

                return routes.export.bulk().then((response) => {
                    var headers = response.headers;
                    let blob = new Blob([response.data],{type:headers.get('content-type')});
                    let link = document.createElement('a');
                    let filename = (response.headers.get('content-disposition') || '').split('filename=')[1];
                        filename = filename.replace(/"/g, '');
                    link.href = window.URL.createObjectURL(blob);
                    link.download = filename;
                    link.click(); // Downloads...
                    UX.setTarget(event).replaceWithNonSpin().removeClicked();
                }).catch((result) => {
                });
            },
        },
        computed: {
            computedReports: function () {

                if (! this.reports.length) {
                    return;
                }

                let filteredReports = this.reports;

                return filteredReports;




                // Enable if need to filter

                let found = _.filter(filteredReports, function(o) {
                    return this.isStatus(o.status) && this.isMatch(o);
                }.bind(this));

                this.loading = false;
                return found;
            }
        }
    }
</script>
