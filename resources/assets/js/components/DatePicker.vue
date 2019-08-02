<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    @import '../../sass/app.bs.css';
    .btn-clear {

        height: 50px;
        border: none;
        background-color: transparent;
        outline: none !important;
        border-bottom-left-radius: 0;
        border-top-left-radius: 0;
        margin: 3px;
        position: absolute;
        right: -3px;
        top: 0;
        width: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    div {
        position: relative;
    }
</style>
<template>
    <div>
        <date-picker @change="dateChanged"
          :name="name" ref="dateField"
          :date="dateTime"
          :option="option"
          :placeholder="placeholder">
        </date-picker>
        <div class="btn-clear btn-default" @click="valueClear" type="button" v-if="showClear"><i class="fa fa-times" aria-hidden="true"></i>
        </div>
    </div>
</template>
<script>
    import DatePicker from 'vue-datepicker'
    let formatHelper = require ('../helpers/format.js').default

    export default {
        name: 'inverse-date-picker',
        data () {
            return {
                //dateTime: {"time":  formatHelper.date(this.value, this.format)},
                // use what date is given to us
                dateTime: {"time": this.value},
                Perm: Perm,
                option: {
                        type: this.type,
                        week: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
                        month: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                        format: this.format,
                        placeholder: this.placeholder,
                        inputStyle: this.inputStyle
                }
            }
        },
        props: {
            inputStyle: {
                type: Object,
                default: function() {
                    return {
                        'text-align': 'center'
                    }
                }
            },
            showClear: {
                type: Boolean,
                default: true
            },
            type: {
                type: String,
                default: 'day',
            },
            format:  {
                type: String,
                default: 'YYYY-MM-DD HH:mm:00',
            },
            name: {
                type: String,
                default: 'date'
            },
            value: {
                type: String,
                default: null
            },
            placeholder: {
                type: String,
                default: "Pick date"
            }
        },
        created () {
        },
        destroyed () {
        },
        computed: {
        },
        components: {
            DatePicker,
        },
        methods: {
            dateChanged: function (data)
            {
                // Emit as you see; we'll have to convert dates in other places
                //data = formatHelper.date(data); // default format
                this.$emit('input', data);
            },
            valueClear: function ()
            {
                this.dateTime.time = '';
            }
        }
    }
</script>
