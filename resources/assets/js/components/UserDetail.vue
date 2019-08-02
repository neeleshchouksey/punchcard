<style lang="sass" scoped>
    @import '../../sass/_variables.scss';

    div {
        .top {
            margin-top: 20px;
        }
    }
    .profile-header {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        i {
           // width: 20px;
           margin-right: 5px;
        }
    }
      .collapsible-header{
        z-index: 1;
      }
    .collapsible-header:hover {
        cursor: pointer;
    }
    .panel-collapsed {
        display: none;
    }
    .profile-buttons {
        display: flex;
    }
    .btn-cancel:hover {
        background-color: $theme-failure-red;
        color: white;
    }
    .btn-submit:hover {
        background-color: $theme-success-green;
        color: white;
    }
    .row {
        margin: 0;
    }
    h4 i {
        font-size: 1.5rem;
    }
      h4 + .collapsible-content {
    z-index: auto;
  }


</style>
<template>
<div v-if="user">
    <div class='row profile-header'>
        <div class="col-sm-4">
            <secure-img :src="user.avatar" :edit_mode="edit_mode" className="img-rounded img-responsive" @image-uploaded="handleImageUpload"></secure-img>
        </div>
        <input type="hidden" name="image" v-model="user.image" />
        <div class='col-sm-8'>
            <h3><i class="fa fa-user-circle" aria-hidden="true"></i>{{user.name}} ({{user.username}})</h3>
            <h5><i class="fa fa-envelope-o" aria-hidden="true"></i><a :href="'mailto:' + user.email">{{user.email}}</a></h5>
            <h5><i class="fa fa-building-o" aria-hidden="true"></i>
                <router-link v-if="user.client" :to="{ path: '/client/' + user.client.uniq_id }">
                    {{user.client.name}}
                </router-link>
            </h5>
            <h5><i class="fa fa-address-card" aria-hidden="true"></i>{{user.jdoc.job_title}}</h5>
            <h5><i class="fa fa-phone" aria-hidden="true"></i>H:
                <formatter mask="phone" v-model="user.jdoc.homeNumber"></formatter>
            </h5>
            <h5><i class="fa fa-phone" aria-hidden="true"></i>W:
                <formatter mask="phone" v-model="user.jdoc.workNumber"></formatter>
            </h5>
            <h5><i class="fa fa-phone" aria-hidden="true"></i>M:
                <formatter mask="phone" v-model="user.mobileNumber"></formatter>
            </h5>
            <h5><i class="fa fa-id" aria-hidden="true"></i>ID:
                {{ user.uniq_id }}
            </h5>
            <h5 v-if="user.client.plan_test=='trial' && user.role == 'clientadmin'"><i class="fa fa-id" aria-hidden="true"></i>Days Left:
              {{calculateRemainingDays()}}
            </h5>

            <h5 v-if="user.role == 'clientadmin' && isCurrentMonthPunchAvailable"><i class="fa fa-id" aria-hidden="true"></i>Total Number of Unique Punches Since {{getCurrentDate()}}:
              {{currentMonthPunch.punches}}
            </h5>

            <h5 v-if="user.role == 'clientadmin' && isCurrentMonthPunchAvailable"><i class="fa fa-id" aria-hidden="true"></i>Total amount due since last billing cycle:
              <span v-if="user.client.plan_test == 'base'">{{1*currentMonthPunch.punches}}</span>
              <span v-if="user.client.plan_test == 'standard'">{{2*currentMonthPunch.punches}}</span>
            </h5>

            <h5 v-if="user.role == 'clientadmin' && isCurrentMonthPunchAvailable"><i class="fa fa-id" aria-hidden="true"></i>Next billing date:
              {{currentMonthPunch.next_billing_date}}
            </h5>

        </div>
    </div>

    <div class='row'>
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Main profile
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
            <form-input :edit_mode="edit_mode" v-model="user.first_name" v-on:input="emitChange">
                First Name<span style="color:red;">*</span>
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.jdoc.middleName" v-on:input="emitChange">
                Middle Name
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.last_name" v-on:input="emitChange">
                Last Name<span style="color:red;">*</span>
            </form-input>



            <form-input :edit_mode="edit_mode" v-model="user.jdoc.job_title" v-on:input="emitChange">
                Employee Title
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.jdoc.department" v-on:input="emitChange">
                Department
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.jdoc.trade" v-on:input="emitChange">
                Trade
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.username" v-on:input="emitChange">
                Username<span style="color:red;">*</span>
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.email" v-on:input="emitChange">
                Email<span style="color:red;">*</span>
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.mobileNumber" v-on:input="emitChange">
                Mobile Number<span style="color:red;">*</span>
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.jdoc.homeNumber" v-on:input="emitChange">
                Home Number
            </form-input>

            <form-input :edit_mode="edit_mode" v-model="user.jdoc.workNumber" v-on:input="emitChange">
               Work Number
            </form-input>

            <form-dropdown :edit_mode="edit_mode" v-model="user.role" :options="roleOptions" v-if="adminEditingUser">
                Role
            </form-dropdown>

            <form-dropdown :edit_mode="edit_mode" v-model="user.status" :options="statusOptions" v-if="user.status && adminEditingUser">
               Status
            </form-dropdown>
        </div>
    </div>

    <div class='row'>
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Primary Address
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
            <form-input name="user.jdoc.primaryAddress.address1" :edit_mode="edit_mode" v-model="user.jdoc.primaryAddress.address1" v-on:input="emitChange">
                Address 1
            </form-input>

            <form-input name="user.jdoc.primaryAddress.address2" :edit_mode="edit_mode" v-model="user.jdoc.primaryAddress.address2" v-on:input="emitChange">
                Address 2
            </form-input>

            <form-input name="user.jdoc.primaryAddress.city" :edit_mode="edit_mode" v-model="user.jdoc.primaryAddress.city" v-on:input="emitChange">
                City
            </form-input>

            <form-input name="user.jdoc.primaryAddress.state" :edit_mode="edit_mode" v-model="user.jdoc.primaryAddress.state" v-on:input="emitChange">
                State
            </form-input>

            <form-input name="user.jdoc.primaryAddress.zip" :edit_mode="edit_mode" v-model="user.jdoc.primaryAddress.zip" v-on:input="emitChange">
                Zip
            </form-input>
        </div>
    </div>

    <div class='row'>
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Secondary Address
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
            <form-input name="user.jdoc.secondaryAddress.address1" :edit_mode="edit_mode" v-model="user.jdoc.secondaryAddress.address1" v-on:input="emitChange">
                Address 1
            </form-input>

            <form-input name="user.jdoc.secondaryAddress.address2" :edit_mode="edit_mode" v-model="user.jdoc.secondaryAddress.address2" v-on:input="emitChange">
                Address 2
            </form-input>

            <form-input name="user.jdoc.secondaryAddress.city" :edit_mode="edit_mode" v-model="user.jdoc.secondaryAddress.city" v-on:input="emitChange">
                City
            </form-input>

            <form-input name="user.jdoc.secondaryAddress.state" :edit_mode="edit_mode" v-model="user.jdoc.secondaryAddress.state" v-on:input="emitChange">
                State
            </form-input>

            <form-input name="user.jdoc.secondaryAddress.zip" :edit_mode="edit_mode" v-model="user.jdoc.secondaryAddress.zip" v-on:input="emitChange">
                Zip
            </form-input>
        </div>
    </div>

    <div class='row'>
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Vehicle
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
            <form-input name="user.jdoc.vehicle.carMake" :edit_mode="edit_mode" v-model="user.jdoc.vehicle.carMake" v-on:input="emitChange">
                Car Make
            </form-input>

            <form-input name="user.jdoc.vehicle.carModel" :edit_mode="edit_mode" v-model="user.jdoc.vehicle.carModel" v-on:input="emitChange">
                Car Model
            </form-input>
            <form-input name="user.jdoc.vehicle.driversLicenseNumber" :edit_mode="edit_mode" v-model="user.jdoc.vehicle.driversLicenseNumber" v-on:input="emitChange">
                Drivers License Number
            </form-input>
            <form-input name="user.jdoc.vehicle.driversLicenseState" :edit_mode="edit_mode" v-model="user.jdoc.vehicle.driversLicenseState" v-on:input="emitChange">
                Drivers License State
            </form-input>

            <form-input name="user.jdoc.vehicle.licPlateNumber" :edit_mode="edit_mode" v-model="user.jdoc.vehicle.licPlateNumber" v-on:input="emitChange">
                License Plate Number
            </form-input>

            <form-input name="user.jdoc.vehicle.licPlateState" :edit_mode="edit_mode" v-model="user.jdoc.vehicle.licPlateState" v-on:input="emitChange">
                License Plate State
            </form-input>
        </div>
    </div>

    <div class='row'>
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Emergency Contact
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
            <form-input name="name" :edit_mode="edit_mode" v-model="user.jdoc.emerContact.name" v-on:input="emitChange">
                Name
            </form-input>

            <form-input name="user.jdoc.emerContact.relation" :edit_mode="edit_mode" v-model="user.jdoc.emerContact.relation" v-on:input="emitChange">
                Relation
            </form-input>

            <form-input name="user.jdoc.emerContact.homeNumber" :edit_mode="edit_mode" v-model="user.jdoc.emerContact.homeNumber" v-on:input="emitChange">
                Home Phone
            </form-input>

            <form-input name="user.jdoc.emerContact.workNumber" :edit_mode="edit_mode" v-model="user.jdoc.emerContact.workNumber" v-on:input="emitChange">
                Work Phone
            </form-input>

            <form-input name="user.jdoc.emerContact.mobileNumber" :edit_mode="edit_mode" v-model="user.jdoc.emerContact.mobileNumber" v-on:input="emitChange">
                Mobile Phone
            </form-input>

            <form-input name="user.jdoc.emerContact.email" :edit_mode="edit_mode" v-model="user.jdoc.emerContact.email" v-on:input="emitChange">
                Email
            </form-input>
        </div>
    </div>

    <div class='row'>
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Scheduling
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
          <form-dropdown :edit_mode="edit_mode" v-model="user.jdoc.scheduling.workWeekStart" name="user.jdoc.scheduling.workWeekStart" :options="weekDaysOptions" style="text-transform: capitalize;">
              Work Week Start Day
          </form-dropdown>
          <form-dropdown :edit_mode="edit_mode" v-model="user.jdoc.scheduling.paySchedule" name="user.jdoc.scheduling.paySchedule" :options="scheduleOptions" style="text-transform: capitalize;">
              Pay Schedule
          </form-dropdown>
          <form-dropdown :edit_mode="edit_mode" v-model="user.jdoc.scheduling.payPeriod" name="user.jdoc.scheduling.payPeriod" :options="payPeriodOptions" style="text-transform: capitalize;">
              Pay Period
          </form-dropdown>
          <!-- <form-dropdown :edit_mode="edit_mode" v-model="user.jdoc.scheduling.dailyStartTime" name="user.jdoc.scheduling.dailyStartTime" :options="dailyTimeOptions">
              Daily Start Time
          </form-dropdown> -->

          <div class="row" style="display: inline-flex;width:100%">
            <label style="width: 26%;margin-left: 10px;">
                Daily Start Time
            </label>
              <time-picker v-on:input="startTimeChanged" v-if="edit_mode" v-model="user.jdoc.scheduling.dailyStartTime" style="width: 74%;">
              </time-picker>
              <div v-if="!edit_mode">{{user.jdoc.scheduling.dailyStartTime}}</div>
          </div>


          <!-- <form-dropdown :edit_mode="edit_mode" v-model="user.jdoc.scheduling.dailyEndTime" name="user.jdoc.scheduling.dailyEndTime" :options="dailyTimeOptions">
              Daily End Time
          </form-dropdown> -->

          <div class="row" style="display: inline-flex;width:100%">
            <label style="width: 26%;margin-left: 10px;">
                Daily End Time
            </label>
              <time-picker v-on:input="endTimeChanged" v-if="edit_mode" v-model="user.jdoc.scheduling.dailyEndTime" style="width: 74%;">
              </time-picker>
              <div v-if="!edit_mode">{{user.jdoc.scheduling.dailyEndTime}}</div>
          </div>
          <form-dropdown :edit_mode="edit_mode" v-model="user.jdoc.scheduling.lunchTimeAmount" name="user.jdoc.scheduling.lunchTimeAmount" :options="lunchTimeOptions">
              Amount of Time for Lunch
          </form-dropdown>
        </div>
    </div>

    <div class='row' v-if="adminEditingUser">
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Payroll and WC Insurance
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
            <!-- <form-input :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.pay_rate" v-on:input="emitChange">
                Pay Rate
            </form-input> -->
            <form-input name="user.jdoc.payroll_data.estimatedHoursMonth" :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.estimatedHoursMonth" v-on:input="calculateEstimatedPremimum">
                Estimated Hours / Mo
            </form-input>
            <form-input name="user.jdoc.payroll_data.pay_rate" :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.pay_rate" v-on:input="calculateEstimatedPremimum">
                Pay Rate
            </form-input>
            <form-input name="user.jdoc.payroll_data.wcGocClassCode" :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.wcGocClassCode" v-on:input="emitChange">
                WC Governing Class Code
            </form-input>
            <form-input name="user.jdoc.payroll_data.state" :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.state" v-on:input="emitChange">
                State
            </form-input>
            <form-input name="user.jdoc.payroll_data.rate" :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.rate" v-on:input="calculateEstimatedPremimum">
                Rate
            </form-input>
            <form-input name="user.jdoc.payroll_data.expModifier" :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.expModifier" v-on:input="calculateEstimatedPremimum">
                Experience Modifier
            </form-input>

            <form-input name="user.jdoc.payroll_data.estimatedPremium" :edit_mode="edit_mode" v-model="user.jdoc.payroll_data.estimatedPremium" v-on:input="emitChange">
                Estimated Premium Monthly
            </form-input>

        </div>
    </div>

    <div class='row'>
        <h4 class='collapsible-header'>
            <i class='fa fa-chevron-right'></i>
            Demographics (Optional)
        </h4>
        <div :class="[showExpanded ? editingClass : notEditingClass]">
          <form-dropdown name="user.jdoc.demographics.sex" :edit_mode="edit_mode" v-model="user.jdoc.demographics.sex" :options="genderOptions" style="text-transform: capitalize;">
              Sex
          </form-dropdown>
          <form-dropdown name="user.jdoc.demographics.ethnicity" :edit_mode="edit_mode" v-model="user.jdoc.demographics.ethnicity" :options="ethnicityOptions" style="text-transform: capitalize;">
              Ethnicity
          </form-dropdown>

            <div class="row" style="display: inline-flex;width:100%">
              <label style="width: 26%;margin-left: 10px;">
                  Drug Test Date
              </label>
                <inverse-date-picker v-on:input="drugTestDateChanged" v-if="edit_mode" v-model="user.jdoc.demographics.drugTestDate" style="width: 74%;" :format="'YYYY-MM-DD'">
                </inverse-date-picker>
                <div v-if="!edit_mode">{{user.jdoc.demographics.drugTestDate}}</div>
            </div>
            <form-dropdown name="user.jdoc.demographics.drugTestResult" :edit_mode="edit_mode" v-model="user.jdoc.demographics.drugTestResult" :options="testResultOptions" style="text-transform: capitalize;">
              Drug Test Result
            </form-dropdown>
            <div class="row" style="display: inline-flex;width:100%">
              <label style="width: 26%;margin-left: 10px;">
                  Background Check Date
              </label>
                <inverse-date-picker v-on:input="backgroundCheckDateChanged" v-if="edit_mode" v-model="user.jdoc.demographics.backgroundCheckDate" style="width: 74%;" :format="'YYYY-MM-DD'">
                </inverse-date-picker>
                <div v-if="!edit_mode">{{user.jdoc.demographics.backgroundCheckDate}}</div>
            </div>

            <form-dropdown name="user.jdoc.demographics.backgroundCheckResult" :edit_mode="edit_mode" v-model="user.jdoc.demographics.backgroundCheckResult" :options="testResultOptions" style="text-transform: capitalize;">
              Background Check Result
            </form-dropdown>
        </div>
    </div>
</div>
</template>
<script>
    import Formatter from './Formatter.vue';
    let imageUpload = require ('../helpers/imageupload.js').default;
    //import InverseDatePicker from './DatePicker.vue'
    import FormInput from './ReactiveFormInput.vue'

    import FormHidden from './FormHidden.vue';
    import SecureImg from './SecureImg.vue';
    import FormDropdown from './FormSelect.vue';
    import Config from '../config'
    import InverseDatePicker from './DatePicker.vue'
    import TimePicker from './TimePicker.vue'

    export default {
        name: 'user-detail-component',
        data () {
            return {
                editingClass: 'col-sm-8 collapsible-content',
                notEditingClass: 'panel-collapsed col-sm-8 collapsible-content',
                user: this.value,
                statusOptions: [
                    {text: 'Active', value: 'active' },
                    {text: 'Inactive', value: 'inactive' }
                ],
                loading: true,
                currentMonthPunch : {
                  next_billing_date: "",
                  punches: "",
                },
                isCurrentMonthPunchAvailable : false,

                weekDaysOptions: Config.weekDaysOptions(),
                scheduleOptions: Config.scheduleOptions(),
                payPeriodOptions: Config.payPeriodOptions(),
                dailyTimeOptions: Config.dailyTimeOptions(),
                lunchTimeOptions: Config.lunchTimeOptions(),
                genderOptions: Config.genderOptions(),
                testResultOptions: Config.testResultOptions(),
                ethnicityOptions: Config.ethnicityOptions(),

            }
        },
        created() {
          if(this.user.role == 'clientadmin'){
            this.$store.dispatch('getCurrentMonthPunchDetails').then((response) => {
              this.currentMonthPunch = response.data.data;
              this.isCurrentMonthPunchAvailable = true;
              console.log("response.data.data",response.data.data);
            });
          }

          if(!this.user.jdoc.payroll_data)
            this.user.jdoc.payroll_data = {}
          if(!this.user.jdoc.emerContact)
            this.user.jdoc.emerContact = {}
          if(!this.user.jdoc.vehicle)
            this.user.jdoc.vehicle = {}
          if(!this.user.jdoc.primaryAddress)
            this.user.jdoc.primaryAddress = {}
          if(!this.user.jdoc.secondaryAddress)
            this.user.jdoc.secondaryAddress = {}
          if(!this.user.jdoc.scheduling)
            this.user.jdoc.scheduling = {}
          if(!this.user.jdoc.demographics)
            this.user.jdoc.demographics = {}
        },
        mounted () {
            $('.collapsible-header').click(function() {
                const content = $(this).next();
                if (content.hasClass('panel-collapsed')) {
                    content.removeClass('panel-collapsed');
                    content.slideDown();
                    $(this).find('i').removeClass('fa fa-chevron-right').addClass('fa fa-chevron-down');
                } else {
                    content.addClass('panel-collapsed');
                    content.slideUp();
                    $(this).find('i').removeClass('fa fa-chevron-down').addClass('fa fa-chevron-right');
                }
            });
        },
        props: {
            roleOptions: {
                type: Array,
                default: []
            },
            expanded: {
                type: Boolean,
                default: false
            },
            edit_mode: {
                type: Boolean,
                default: false
            },
            type: {
                type: String,
                default: 'profile'
            },
            value: {
                type: Object,
                default: function () {
                    return {
                        name: null,
                        uniq_id: null,
                        avatar: null,
                        image : null,
                        jdoc: {
                            job_title: null,
                            middleName: null,

                            emerContact: {
                                name: null,
                                relation: null,
                                homePhone: null,
                                workPhone: null,
                                mobilePhone: null,
                                email: null
                            },
                            vehicle: {
                                carMake: null,
                                carModel:null,
                                driversLicenseNumber:null,
                                driversLicenseState:null,
                                licPlateNumber:null,
                                licPlateState:null
                           },
                           primaryAddress : {
                             address1 : null,
                             address2 : null,
                             city : null,
                             state : null,
                             zip : null,
                           },
                           secondaryAddress : {
                             address1 : null,
                             address2 : null,
                             city : null,
                             state : null,
                             zip : null,
                           },
                           scheduling :{
                             workWeekStart: null,
                             paySchedule: null,
                             payPeriod: null,
                             dailyStartTime: null,
                             dailyEndTime: null,
                             lunchTimeAmount: null,
                           },
                            payroll_data: {
                                estimatedHoursMonth : null,
                                pay_rate: null,
                                wcGocClassCode: null,
                                state: null,
                                rate: null,
                                expModifier: null,
                                estimatedPremium: null
                            },
                            demographics : {
                              sex : null,
                              ethnicity : null,
                              drugTestDate : null,
                              drugTestResult : null,
                              backgroundCheckDate : null,
                              backgroundCheckResult: null
                            }
                        }
                    }
                },
            },
        },
        computed: {
            showExpanded() {
                return this.edit_mode || this.expanded;
            },

            adminEditingUser: function()
            {
                return this.type == 'adminEditing'
            },
            payRate() {
                if (typeof this.user.jdoc === 'undefined') {
                    return false;
                }

                if (this.user.jdoc === null) {
                    return false;
                }

                if (typeof this.user.jdoc.payroll === 'undefined') {
                    return false;
                }

                if (typeof this.user.jdoc.payroll_data.pay_rate  === 'undefined') {
                    return false;
                }

                return true;
                //return this.user.jdoc.payroll_data.pay_rate;
            },
            internalId: function()
            {
                return '(Internal ID: ' + this.user.id + ')'
            },
        },
        components: {
            SecureImg,
            FormHidden,
            FormInput,
            Formatter,
            FormDropdown,
            InverseDatePicker,
            TimePicker
        },
        methods: {
          calculateRemainingDays() {
            var end = Moment(this.user.client.created_at);
            var now = Moment(new Date()); //todays date
            var duration = Moment.duration(now.diff(end));
            console.log(Math.floor( duration.asDays()-30 ), duration);
            return Math.floor( duration.asDays()-30 );
          },
          drugTestDateChanged : function(data){
            this.user.jdoc.demographics.drugTestDate = data;
          },
          startTimeChanged : function(data){
            this.user.jdoc.scheduling.dailyStartTime = data;
          },
          endTimeChanged : function(data){
            this.user.jdoc.scheduling.dailyEndTime = data;
          },
          backgroundCheckDateChanged : function(data){
            this.user.jdoc.demographics.backgroundCheckDate = data;
          },
          getCurrentDate :function(){
            return Moment(new Date()).format('DD-MM-YYYY');
          },
          calculateEstimatedPremimum : function(){
            if(this.user.jdoc.payroll_data.estimatedHoursMonth && this.user.jdoc.payroll_data.pay_rate && this.user.jdoc.payroll_data.expModifier && this.user.jdoc.payroll_data.rate){
              try {
                var estimatedPremium = 0;
                estimatedPremium = Number(this.user.jdoc.payroll_data.estimatedHoursMonth) * Number(this.user.jdoc.payroll_data.pay_rate);
                estimatedPremium = estimatedPremium/100;
                estimatedPremium = estimatedPremium * Number(this.user.jdoc.payroll_data.rate);
                estimatedPremium = Math.round(estimatedPremium * 100) / 100;
                estimatedPremium = estimatedPremium * Number(this.user.jdoc.payroll_data.expModifier);
                estimatedPremium = Math.round(estimatedPremium * 100) / 100;

                console.log("estimatedPremium", estimatedPremium);
                if(estimatedPremium){
                  this.user.jdoc.payroll_data.estimatedPremium = estimatedPremium;
                } else {
                  this.user.jdoc.payroll_data.estimatedPremium = 0;
                }
              } catch (e) {
                this.user.jdoc.payroll_data.estimatedPremium = 0;
              }

            }
          },
            emitChange: function() {
                this.$emit('input', this.value);
            },

            handleImageUpload(imgInfo, imgData) {
              console.log("profile type: ",this.type);
              if(this.type=='profile'){
                let result = imageUpload.saveUserAvatar(imgInfo, imgData, this.user).then((result) => {
                  this.$store.dispatch('showAlertSuccess',
                      {
                          title: "Success",
                          msg: "Image updated successfully"
                      });
                });
              } else {
                let imgSplit = imgData.split(',', 2);
                this.user.image = imgSplit[1];
              }
            },
        }
    }
</script>
