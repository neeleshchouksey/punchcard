<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    @import '../../../sass/app.bs.css';
    #forecast {
        width: 100%;
        tr {width: 100%;}
        td {width: 20%; text-align: center;}
    }

    div {
        .center {
            text-align: center;
        }
    }
</style>
<template>
    <div>
        <div class="row">
            <div class="col-sm-1">
            </div>
            <div class="col-sm-2" v-for="day in computedForecastMoments">
                <div class="row center">
                    {{ day.day }}
                </div>
                <div class="row center">
                    <img :src="iconSrc(day.icon)" />
                    {{ day.high }}/{{ day.low }}
                </div>
                <div class="row center">
                    {{ day.description }}
                </div>
            </div>
            <div class="col-sm-1">
            </div>
        </div>
    </div>
</template>
<script>
    let formatHelper = require('../../helpers/format').default

    export default {
        name: 'weather-forecast',
        data () {
            return {
                Perm: Perm,
                loading: true
            }
        },
        created () {
            this.loading = false
        },
        props: {
            value: {
                type: Object,
                default: function () {
                    return {
                        list: [],
                    }
                }
            },
        },
        computed: {
            computedForecastMoments: function () {

                if (this.value.list.length == 0) {
                    return null
                }

                let mod_index = -1
                let ret = _(this.value.list).map(m => {
                    ++mod_index

                    if (mod_index % 8 != 0) {
                        return false
                    }

                    return {
                        "low": m.main.temp_min,
                        "high": formatHelper.round(m.main.temp_max, 0),
                        "icon": m.weather[0].icon,
                        "description": m.weather[0].main,
                        "day": Moment(m.dt_txt).format('ddd'),
                    }
                }).filter(m => { return m != false }).value();

                return ret
            }
        },
        components: {
        },
        methods: {
            iconSrc: function (icon)
            {
                return "http://openweathermap.org/img/w/" + icon + '.png'
            },
        }
    }
</script>
