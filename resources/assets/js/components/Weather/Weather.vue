<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div class="col-sm-12">
        <loader :loading="loading" loading_msg="Loading Weather..."></loader>
        <div class="row" style="text-align: center">
            <h3>Weather Conditions for {{ value }}</h3>
        </div>
        <div class="row">
            <current v-if="computedCurrent" v-model="computedCurrent"></current>
        </div>
        <div class="row">
            <forecast v-if="computedForecast" v-model="computedForecast"></forecast>
        </div>
    </div>
</template>
<script>
    import Forecast from './Forecast.vue'
    import Current from './Current.vue'

    export default {
        name: 'weather-base',
        data () {
            return {
                Perm: Perm,
                loading: true,
                weather: {
                    current: null,
                    forecast: null
                },
            }
        },
        created () {
            let routes     = Api.getRoutes('weather');

            routes.weather.current(this.value).then((response) => {
                this.weather.current = response
            }).catch((response) => {
            })

            routes.weather.forecast(this.value).then((response) => {
                this.weather.forecast = response
            }).catch((response) => {
            })

            this.loading = false
        },
        props: {
            value: {
                type: String,
                default: null
            },
        },
        computed: {
            computedForecast: function ()
            {
                if (this.weather.forecast === null) {
                    return null
                }

                return this.weather.forecast
            },
            computedCurrent: function ()
            {
                if (this.weather.current === null) {
                    return null
                }

                return this.weather.current
            },
        },
        components: {
            Forecast,
            Current
        },
        methods: {
        }
    }
</script>
