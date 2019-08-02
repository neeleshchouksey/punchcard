<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {
        .pick-transition {
            transition: all 1s ease;
            border-width: 1px;
        }

        .pick-enter {
            border: 2px solid #00f;
        }

        .pick-leave {
            border: 5px solid #0f0 ;
        }

        select {
            width: 200px;
            margin: 15px 0;
        }
        select option {
            padding: 125px;
        }
        thead tr {
            background-color: $theme-gold;
        }
        tr {
            padding: 5px;
            padding-bottom: 20px;
        }

        td {
            vertical-align: center;
            text-align: center;
            &:first-child {
                text-align: left;
            }
        }

        tbody tr {
            &:nth-child(odd) {
                background-color: lighten($theme-gold, 25%);
            }
        }

        tr.sort td:hover {
            cursor: pointer;
            background: $laravel-border-color;
        }
    }
</style>
<template>
    <div>
        <h3>Timesheets</h3>

        <h4 v-if="!hasTimesheets">
            No timesheets are yet available for this user.
        </h4>

        <div v-if="hasTimesheets">

            <select @change="toggleView">
                <option>Punches</option>
                <option>Weekly</option>
            </select>

            <table v-if="!punchesView" class="table table-striped" style="border-radius: 15px;">
                <thead>
                    <tr>
                        <td></td>
                        <td>Monday</td>
                        <td>Tuesday</td>
                        <td>Wednesday</td>
                        <td>Thursday</td>
                        <td>Friday</td>
                        <td>Saturday</td>
                        <td>Sunday</td>
                        <td>Total</td>
                   </tr>
                </thead>
                <tbody>
                   <tr v-for="(weekData, weekRange) in computedTimesheetsByWeek">
                        <td>{{ weekRange }}</td>
                        <td>{{ round(weekData["Mon"],2,true) }}</td>
                        <td>{{ round(weekData["Tue"],2,true) }}</td>
                        <td>{{ round(weekData["Wed"],2,true) }}</td>
                        <td>{{ round(weekData["Thu"],2,true) }}</td>
                        <td>{{ round(weekData["Fri"],2,true) }}</td>
                        <td>{{ round(weekData["Sat"],2,true) }}</td>
                        <td>{{ round(weekData["Sun"],2,true) }}</td>
                        <td>{{ round(weekData["Total"],2,true) }}</td>
                   </tr>
                   </tr>
                </tbody>
            </table>

            <button v-if="punchesView" ref="editButton" @click="toggleEditing">edit</button>
            <table v-if="punchesView" class="table table-striped" style="border-radius: 15px;">
                <thead>
                    <tr class="sort" v-if="!editing">
                        <td @click="sortRows('project.name')"><i class="fa fa-sort"></i> Project Name</td>
                        <td @click="sortRows('checkInDateTime')"><i class="fa fa-sort"></i> Checked In</td>
                        <td @click="sortRows('checkOutDateTime')"><i class="fa fa-sort"></i> Checked Out</td>
                   </tr>
                </thead>
                <tbody>
                   <tr v-for="sheet in computedTimesheets">
                       <td>{{ sheet.project.name }}</td>
                      <td>
                            <inverse-date-picker
                                v-if="editing"
                                v-model="sheet.checkInDateTime"
                                v-on:input="saveCheck('checkInDateTime', sheet, $event)"
                                type="min"
                                :input-style="{'background': 'transparent', 'padding': '3px', 'text-align': 'center'}"
                                :show-clear="false"
                                placeholder="Choose start date">
                            </inverse-date-picker>
                            <span v-if="!editing">
                                {{ sheet.checkInDateTimeFormatted }}
                            </span>
                      </td>
                      <td>
                            <inverse-date-picker
                                v-if="editing"
                                v-model="sheet.checkOutDateTime"
                                v-on:input="saveCheck('checkOutDateTime', sheet, $event)"
                                type="min"
                                :input-style="{'background': 'transparent', 'padding': '3px', 'text-align': 'center'}"
                                :show-clear="false"
                                placeholder="Choose start date">
                            </inverse-date-picker>
                            <span v-if="!editing">
                                {{ sheet.checkOutDateTimeFormatted }}
                            </span>
                      </td>
                   </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>
<script>
    import InverseDatePicker from '../../components/DatePicker.vue'
    let formatHelper = require ('../../helpers/format.js').default

    export default {
        name: 'user-timesheets',

        data () {
            return {
                format: 'YYYY-MM-DD h:mm a',
                editing: false,
                orderBy: ['checkInDateTime'],
                orderDir: ['desc'],
                loading: true,
                punchesView: true,
                uniq_id: null,
                timesheets: [
                    {
                        project: {
                            name: 'Checking...',
                        }
                    },
                ]
            }
        },
        created () {
            this.uniq_id = this.$route.params.user_id;

            this.$store.dispatch('getTimesheets', this.uniq_id).then((timesheets) => {
                this.timesheets = _.orderBy(timesheets, this.orderBy, this.orderDir)
                this.loading = false;
            });
        },
        computed: {
            hasTimesheets: function ()
            {
                return this.timesheets.length > 0
            },
            computedTimesheets: function ()
            {
                if (! this.timesheets.length) {
                    return;
                }

                return _.map(this.timesheets, function(sheet) {
                    if (sheet.checkOutDateTimeFormatted == 'Invalid date') {
                        sheet.checkOutDateTimeFormatted = 'Still checked in';
                    }

                    return sheet;
                });
            },
            computedTimesheetsByWeek: function ()
            {
                if (! this.timesheets.length) {
                    return;
                }

                let ret = {};

                for (let i = 0; i < this.timesheets.length; i++) {
                    let timesheet = this.timesheets[i];

                    //
                    // Still checked in...
                    //
                    if (timesheet.checkInDateTime === null || timesheet.checkOutDateTime === null) {
                        continue;
                    }

                    let inDate  = formatHelper.date(timesheet.checkInDateTime, 'YYYY-MM-DD HH:mm:00')
                    let outDate = formatHelper.date(timesheet.checkOutDateTime, 'YYYY-MM-DD HH:mm:00')
                    let weekDate  = Moment(inDate);
                    let weekStart = weekDate.startOf('isoweek').format("MMM D");
                    let weekEnd   = weekDate.endOf('isoweek').format("MMM D");


                    let dayofWeekWorked  = Moment(inDate).format("ddd");
                    let hoursWorkedStart = Moment(inDate);
                    let hoursWorkedEnd   = Moment(outDate);
                    let hoursWorked = hoursWorkedEnd.diff(hoursWorkedStart, 'hours', true);

                    if (hoursWorked < 0) {
                        continue;
                    }

                    let week_range = weekStart + ' - ' + weekEnd;

                    if (typeof ret[week_range] == 'undefined') {
                        ret[week_range] = {};
                    }

                    if (typeof ret[week_range]['Total'] == 'undefined') {
                        ret[week_range]['Total'] = 0
                    }

                    if (typeof ret[week_range][dayofWeekWorked] === 'undefined') {
                        ret[week_range][dayofWeekWorked] = 0
                    }

                    let hoursWorkedRounded = this.round(hoursWorked, 2);
                    ret[week_range][dayofWeekWorked] += hoursWorkedRounded;
                    ret[week_range]['Total'] += hoursWorkedRounded;
                }

                return ret;
            }
        },
        props: {
        },
        components: {
            InverseDatePicker,
        },
        methods: {
            enter: function(el, done) {
                done()
            },
            leave: function(el, done) {
                done()
            },
            saveCheck: function (type, sheet, data)
            {
                let utcDate = formatHelper.dateToUtc(data);

                let params = {
                    "type": type,
                    "uniq_id": sheet.uniq_id,
                    "date": utcDate
                }

                let routes     = Api.getRoutes('webapp-user');
                routes.timesheets.put(params).then((response) => {
                    this.$store.dispatch('updateTimesheet', response.data.data).then(result => {
                    });
                }).catch((response) => {
                })
            },
            toggleView: function () {
                this.punchesView = !this.punchesView;
            },

            round: function(number, places, allowNull = false)
            {
                return formatHelper.round(number, places, allowNull)
            },
            sortRows: function(orderBy)
            {
                if (this.timesheets.length <= 0) {
                    return
                }

                this.orderBy = [orderBy]
                this.orderDir = (this.orderDir.indexOf('desc') > -1) ? ['asc'] : ['desc']
                this.timesheets = _.orderBy(this.timesheets, this.orderBy, this.orderDir)
            },
            toggleEditing: function()
            {
                this.editing = !this.editing
                if (this.editing) {
                    this.$refs.editButton.innerText = 'done';
                } else {
                    this.$refs.editButton.innerText = 'edit';
                }

            }

        }
    }
</script>
