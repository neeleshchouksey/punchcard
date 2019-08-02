<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {
        .data-import {
            border: 1px solid #ccc;
            padding: 15px;
            margin: 5px;
        }
    }
</style>
<template>
    <div v-permission="'DataImport'">
        <h1>
            Data Import
        </h1>
        <p>Fields can be in any order and will be added as using the database defaults if they do not exist.</p>
        <p>Currently supported file type: csv.</p>
        <p>Put the list of available headers in the first row, and match the data rows to the header order</p>

        <div class="row" v-permission="'DataImportClients'">
            <h3>Companies</h3>
            <div class="data-import" style="position:relative">
                <div class="available-fields">
                    Available:
                    name, fein, dba, address, city, state, zip, phone, fax, website, status
                    <span v-if="canImportSubdomain">, subdomain (applies to parent companies only)</span>
                </div>

                <file-upload-form method="POST" action="/webapp/data-imports/clients"
                    v-model="client"
                    v-on:form-complete="formComplete">
                    <input type="file" ref="fileUploadClient" @change="onFileChange(client, $event)" />
                    <input type="submit" value="Select File and click to import Companies" />
                </file-upload-form>
                <div v-no-permission="'DataImport'">
                    <i>You currently do not have access to the Data Import functionality.</i>
                </div>

                <a style="position: absolute; top: 50px;right: 0;" type="button" class="btn-spaced btn btn-default material" href="sampleCsv/company_punchcard.csv" download>Download Import Template</a>
            </div>
        </div>

        <div class="row" v-permission="'DataImportUsers'">
            <h3>Users</h3>
            <div class="data-import" style="position:relative">
                <div class="available-fields">
                    Available:

                    first_name, last_name, email, client_id, mobileNumber, role, status, username,
                    jdoc_department,
                    jdoc_homeNumber,
                    jdoc_job_title,
                    jdoc_middleName,
                    jdoc_trade,
                    jdoc_workNumber,
                    jdoc_primary_address_address1,
                    jdoc_primary_address_address2,
                    jdoc_primary_address_city,
                    jdoc_primary_address_state,
                    jdoc_primary_address_zip,
                    jdoc_secondry_address_address1,
                    jdoc_secondry_address_address2,
                    jdoc_secondry_address_city,
                    jdoc_secondry_address_state,
                    jdoc_secondry_address_zip,
                    jdoc_emerContact_email,
                    jdoc_emerContact_homeNumber,
                    jdoc_emerContact_mobileNumber,
                    jdoc_emerContact_name,
                    jdoc_emerContact_relation,
                    jdoc_emerContact_workNumber,
                    jdoc_scheduling_payPeriod,
                    jdoc_scheduling_paySchedule,
                    jdoc_scheduling_dailyEndTime,
                    jdoc_scheduling_workWeekStart,
                    jdoc_scheduling_dailyStartTime,
                    jdoc_scheduling_lunchTimeAmount,
                    jdoc_payroll_data_pay_rate,
                    jdoc_payroll_data_rate,
                    jdoc_payroll_data_state,
                    jdoc_payroll_data_expModifier,
                    jdoc_payroll_data_wcGocClassCode,
                    jdoc_payroll_data_estimatedPremium,
                    jdoc_payroll_data_estimatedHoursMonth,
                    jdoc_vehicle_carMake,
                    jdoc_vehicle_carModel,
                    jdoc_vehicle_driversLicenseNumber,
                    jdoc_vehicle_driversLicenseState,
                    jdoc_vehicle_licPlateNumber,
                    jdoc_vehicle_licPlateState,
                    jdoc_demographics_sex,
                    jdoc_demographics_ethnicity,
                    jdoc_demographics_drugTestDate,
                    jdoc_demographics_drugTestResult,
                    jdoc_demographics_backgroundCheckDate,
                    jdoc_demographics_backgroundCheckResult
                </div>
                <div>
                    <file-upload-form method="POST" action="/webapp/data-imports/users"
                        v-model="user"
                        v-on:form-complete="formComplete">

                        <input type="file" ref="fileUploadUser" @change="onFileChange(user, $event)" />
                        <input type="submit" value="Select File and click to import Users" />

                        <div class="available-fields">

                        </div>
                    </file-upload-form>
                </div>
                <a style="position: absolute; top: 50px;right: 0;" type="button" class="btn-spaced btn btn-default material" href="sampleCsv/users_import.csv" download>Download Import Template</a>
            </div>
        </div>

        <div class="row" v-permission="'DataImportProjects'">
            <h3>Projects</h3>
            <div class="data-import" style="position:relative">
                <div class="available-fields">
                    Available: name, description, sector_id, industry_id, startDate, endDate, longitude, latitude, radius, status, jdoc, created_at, updated_at, polyfence, pointfence, address, city, state, zip, county, country
                </div>
                <div>
                    <file-upload-form method="POST" action="/webapp/data-imports/projects"
                        v-model="project"
                        v-on:form-complete="formComplete">
                        <input type="file" ref="fileUpload" @change="onFileChange(project, $event)" />
                        <input type="submit" value="Select File and click to import Projects" />
                    </file-upload-form>
                </div>
                <a style="position: absolute; top: 50px;right: 0;" type="button" class="btn-spaced btn btn-default material" href="sampleCsv/project_punchcard.csv" download>Download Import Template</a>
            </div>
        </div>

        <div class="row" v-permission="'DataImportChecks'">
            <h3>Checks</h3>
            <div class="data-import" style="position:relative">
                <div class="available-fields">
                    Available: user_id, project_id, checkInDateTime, checkOutDateTime, longitudeIn, latitudeIn,
                    longitudeOut, latitudeOut, checkMethod, isExceptionIn, isExceptionOut
                </div>
                <div>
                    <file-upload-form method="POST" action="/webapp/data-imports/checks"
                        v-model="check"
                        v-on:form-complete="formComplete">
                        <input type="file" ref="fileUpload" @change="onFileChange(check, $event)" />
                        <input type="submit" value="Select File and click to import Checks" />
                    </file-upload-form>
                    <div v-no-permission="'DataImport'">
                        <i>You currently do not have access to the Data Import functionality.</i>
                    </div>
                </div>
                <a style="position: absolute; top: 50px;right: 0;" type="button" class="btn-spaced btn btn-default material" href="sampleCsv/checks_punchcard.csv" download>Download Import Template</a>
            </div>
        </div>
    </div>
</template>
<script>
    import FileUploadForm from '../../components/FileUploadForm.vue'

    export default {
        name: 'data-import',
        data () {
            return {
                client: {
                    uniq_id: this.$route.params.uniq_id,
                    file: null
                },
                user: {
                    uniq_id: this.$route.params.uniq_id,
                    file: null
                },
                project: {
                    uniq_id: this.$route.params.uniq_id,
                    file: null
                },
                check: {
                    uniq_id: this.$route.params.uniq_id,
                    file: null
                },
                Perm: Perm,
                loading: true
            }
        },
        created () {
        },
        computed: {
            canImportSubdomain()
            {
                return User.profile().role == 'superadmin';
            },
            canImportChildId()
            {
                return User.profile().role == 'clientadmin';
            },
        },
        components: {
            FileUploadForm
        },
        methods: {
            onFileChange(data, e)
            {
                let files = e.target.files || e.dataTransfer.files;

                if (!files.length) {
                    return;
                }

                let file  = files[0];
                data.file = file
            },
            formComplete: function (data, response)
            {
                if (response.status == 200) {
                    this.$store.dispatch('showAlertSuccess', {
                        title: response.data.data,
                        msg: null
                    });
                } else {
                    this.$store.dispatch('showAlertSuccess', {
                        title: 'Error in submission',
                        msg: null
                    });
                }
            },
        }
    }
</script>
