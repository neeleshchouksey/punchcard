<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    .card {

        width: 200px;
        padding: 17px;
        margin: 20px;
        display: flex;
        flex-grow: 1;
        flex-wrap: wrap;
        &:hover {
            text-decoration: none;
            .card-icon {
                // transform: rotate(10deg);
            }
        }
        .card-header, .card-icon {
            transition: $box-shadow-transition;
            // height: 60px;
        }
        .card-header {
            font-size: 1.3em;
            flex-basis: 80%;
        }
        .card-icon {
            min-width: 20%;
            color: $theme-slate;
            text-align: center;
        }
        .card-description {
            flex-basis: 100%;
            height: 80px;
        }
        hr {
            flex-basis: 100%;
            border-top: 1px solid lighten($theme-gray, 20%);
        }
    }
    .row {
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: center;
    }
    .data-import {
        justify-content: flex-start;
        .card {
            width: calc(100%/3 - 40px);
            flex-grow: 0;
            flex-shrink: 1;
        }
        .data-import-option {
            width: initial;
            height: initial;
            padding: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 0;
            flex-shrink: 1;
            &:hover {
                cursor: pointer;
            }
        }
        img {
            filter: brightness(26%);
        }
    }
</style>
<template>
    <div>
        <div>
            <h2>Company Setup</h2>
            <hr>
            <div class="row">

                <router-link v-permission="'OrganizationOwnContactInfo'"  class="card" :to="{name: 'client-main', params: { uniq_id: clientUniqId}}">
                    <div class='card-header'>
                        Company Information
                    </div>
                    <div class='card-icon'><i class='fa fa-2x fa-id-card'></i></div>
                    <hr>
                    <div class='card-description'>Review or update your company's details and contact information.</div>
                </router-link>

                <router-link v-permission="'OrganizationParentCompanies'" class='card' :to="{name: 'parents-main'}">
                    <div class='card-header'>
                        Parent Companies
                    </div>
                    <div class='card-icon'><i class='fa fa-2x fa-sitemap'></i></div>
                    <hr>
                    <div class='card-description'>Manage parent companies.</div>
                </router-link>

                <router-link v-permission="'OrganizationChildCompanies'" class='card' :to="{name: 'client-children', params: { uniq_id: clientUniqId}}">
                    <div class='card-header'>
                        Child Companies
                    </div>
                    <div class='card-icon'><i class='fa fa-2x fa-sitemap'></i></div>
                    <hr>
                    <div class='card-description'>Manage your organizational structure by adding, editing, or removing child companies.</div>
                </router-link>

                <router-link v-permission="'OrganizationOwnEmployees'" class='card' :to="{name: 'client-employees', params: { uniq_id: clientUniqId}}">
                    <div class='card-header'>
                        Employees
                    </div>
                    <div class='card-icon'><i class='fa fa-2x fa-users'></i></div>
                    <hr>
                    <div class='card-description'>Add, edit, or remove employees from your organization.</div>
                </router-link>
            </div>
             <!--  -->
            <div v-if="userProfile.email == 'admin@punchcardllc.com'" class="row">
              <router-link class='card' :to="{name: 'manageuser-employees', params: { uniq_id: clientUniqId}}">
                  <div class='card-header'>
                      IHOS
                  </div>
                  <div class='card-icon'><i class='fa fa-2x fa-sitemap'></i></div>
                  <hr>
                  <div class='card-description'>Add/Edit IHOS Admin Users</div>
              </router-link>
            </div>

            <div  v-permission="'OrganizationImportData'" >
                <h2>Import Data</h2>
                <hr>
                <div class="row data-import">
                        <router-link class="card" :to="{name: 'data-import', params: { uniq_id: clientUniqId}}">
                            <div class="card-header">
                                PunchCard
                            </div>
                            <span class="card-icon">
                                <img title="IHOS Punchcard" alt="[Logo]" :src="logoSrc" width="37" height="32" />
                            </span>
                            <hr>
                            <div class="card-description">Import historical punches, projects and users
                                from previous jobsites.
                            </div>
                        </router-link>
                </div>
            </div>

        </div>
    </div>
</template>
<script>
    import Panel from '../components/Panel.vue'

    export default {
        name: 'organization',
        data () {
            return {
                clientUniqId: null,
                userProfile : {}
            }
        },
        created () {
            let routes = Api.getRoutes('webapp-user');

            routes.profile.get().then((profile) => {
                this.userProfile = profile;
                this.clientUniqId = profile.client.uniq_id;
            });


        },
        computed: {
            cssCompanyInformation: function () {
                return {
                    panelEntire: "min-height: 150px;",
                    panelHead: "",
                    panelBody: ""
                }
            },
            logoSrc: function ()
            {
                return DevConfig.url + 'images/logo.png'
            },
        },
        components: {
            Panel
        },
        methods: {
        }
    }
</script>
