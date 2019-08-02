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
        <vue-timepicker  @change="dateChanged" :minute-interval="15" format="HH:mm"></vue-timepicker>
    </div>
</template>
<script>
    import VueTimepicker from 'vue2-timepicker'
    let formatHelper = require ('../helpers/format.js').default

    export default {
        name: 'time-picker',
        data () {
            return {
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
          Vue.use(VueTimepicker)
        },
        destroyed () {
        },
        computed: {
        },
        components: {
            VueTimepicker,
        },
        methods: {
            dateChanged: function (data)
            {
              this.$emit('input', data.data.HH+":"+data.data.mm);
            },
            valueClear: function ()
            {
                this.dateTime.time = '';
            }
        }
    }
</script>
