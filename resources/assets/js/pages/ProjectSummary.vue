<style lang="sass" scoped>
    @import '../../sass/_variables.scss';

    .not-active {
        // border: 5px solid lighten($theme-dark-red, 30%);
        background-color: lighten($theme-dark-red, 10%);
        display: flex;
        justify-content: center;
        width: 100%;
        height: 25px;
        span {
            color: $theme-white;
        }
    }


    #summary {
        padding: 20px;
        .col-sm-4 {
            padding: 0 30px 0 0;
            height: 100%;
        }
        .card {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-around;
            padding: 5px;
            margin-bottom: 10px;
            min-width: 200px;
            &:hover {
                cursor: default;
            }
            &:not(.not-active) {
                height: 95px;
            }
        }
    }
    #camera-feed {
        width: 100%;
        height: 350px;
        background-color: #444;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: #eee;
        border-radius: 4px;
        i {
            color: $theme-gold;
            &:hover {
                cursor: pointer;
            }
        }
    }


</style>
<template>
    <div>

        <div>
            <div class="not-active" v-if="!isActive && !loading">
                <span>This project is not currently active</span>
            </div>
            <div id='summary' class="row">
                <div class="col-sm-4">
                    <div class="card">
                      <router-link :to="{ path: '/projectEmployeesOnsite/'+project_id+'/null', meta: {}}">
                        <div class='summary-metric'>
                            <i class="fa fa-3x fa-user" aria-hidden="true"></i>
                            <span>{{ employeesOnsite }}</span>
                        </div>
                        <div class='summary-units'>
                            <span class='units-pt-1'>Employees</span>
                            <span class='units-pt-2'> currently on site</span>
                        </div>
                      </router-link>
                    </div>
                    <div class="card">
                      <router-link :to="{ path: '/projectCompanyOnsite/'+project_id, meta: {}}">
                        <div class='summary-units'>
                            <span class='units-pt-1'>Companies</span>
                            <span class='units-pt-2'> currently on site</span>
                        </div>
                        <div class='summary-metric'>
                            <span>{{ companiesOnsite }}</span>
                            <i class="fa fa-3x fa-group" aria-hidden="true"></i>
                        </div>
                        </router-link>
                    </div>
                    <div class="card">
                        <router-link :to="{ path: '/report/0d7bd1c0-d7be-4795-bc1a-26ca793ee681', meta: {}}">
                          <div class='summary-metric'>
                              <i class="fa fa-3x fa-calendar" aria-hidden="true"></i>
                              <span>{{ totalDaysWorkedToDate }}</span>
                          </div>
                          <div class='summary-units'>
                              <span class='units-pt-1'>Days</span>
                              <span class='units-pt-2'> worked to date</span>
                          </div>
                        </router-link>
                    </div>
                    <div class="card">
                      <router-link :to="{ path: '/report/0d7bd1c0-d7be-4795-bc1a-26ca793ee681', meta: {}}">
                        <div class='summary-units'>
                            <span class='units-pt-1'>Hours</span>
                            <span class='units-pt-2'> worked to date</span>
                        </div>
                        <div class='summary-metric'>
                            <span>{{ totalHoursWorkedToDate }}</span>
                            <i class="fa fa-3x fa-clock-o" aria-hidden="true"></i>
                        </div>
                      </router-link>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class='row'>
                        <weather v-model="project.zip" v-if="project.zip"></weather>
                    </div>
                    <div class='row'>
                        <div id='camera-feed'>
                        <span>Camera feed placeholder</span>
                        <i class="fa fa-play fa-4x" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</template>
<script>
    import Panel from '../components/Panel.vue'
    import Weather from '../components/Weather/Weather.vue'

    export default {
        name: 'project-summary',
        data () {
            return {
                Perm: Perm,
                project: {
                    totalHours: 'Loading ',
                    totalDays: 'Loading ',
                    employeesOnsite: 'Loading ',
                    companiesOnsite: 'Loading ',
                    zip: this.$store.state.projects.project.zip,
                },
                loading: true
            }
        },
        created () {
            this.project_id = this.$route.params.project_id;

            this.$store.dispatch('getProject', this.$route.params.project_id).then(() => {  // project_id == uniq_id
                this.project = this.$store.state.projects.project;
                this.users   = this.project.staffed;
                this.loading = false;
            });
        },
        computed: {
            isActive: function ()
            {
                return (this.project.status == 'active')
            },
            totalDaysWorkedToDate: function() {
                if (typeof this.project.stats == 'undefined' || this.project.stats == null) {
                        return 'Loading...';
                }

                return this.project.stats.daysWorked;
            },
            totalHoursWorkedToDate: function() {
                if (typeof this.project.stats == 'undefined' || this.project.stats == null) {
                        return 'Loading...';
                }

                return this.project.stats.hoursWorked;
            },
            employeesOnsite: function() {
                if (typeof this.project.stats == 'undefined' || this.project.stats == null) {
                        return 'Loading...';
                }

                return this.project.stats.employeesOnSite;
            },
            companiesOnsite: function() {
                if (typeof this.project.stats == 'undefined' || this.project.stats == null) {
                        return 'Loading...';
                }

                return this.project.stats.companiesOnSite;
            },

            cssEmployeesOnsite: function() {
                return {
                    panelEntire: "",
                    panelHead: "",
                    panelBody: ""
                }
            },
            cssCompaniesOnsite: function() {
                return {
                    panelEntire: "",
                    panelHead: "",
                    panelBody: ""
                }
            },
            cssTotalDays: function() {
                return {
                    panelEntire: "",
                    panelHead: "",
                    panelBody: ""
                }
            },
            cssTotalHours: function () {
                return {
                    panelEntire: "",
                    panelHead: "",
                    panelBody: ""
                }
            },
            cssMisc: function () {
                return {
                    panelEntire: "",
                    panelHead: "",
                    panelBody: "font-size: 100%"
                }
            }
        },
        components: {
            Panel,
            Weather
        },
        methods: {
        },
        mounted () {
        }
    }
</script>
