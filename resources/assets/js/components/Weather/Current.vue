<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {
        .current-temp {
            font-size: 5rem;
            margin: 0 5px;
        }
    }
    #current-weather {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }
</style>
<template>
    <div>
        <div id="current-weather">
            Currently

            <span class="current-temp">
                <img :src="computedIcon" />
                {{ mainTemp }}°
            </span>
            <span> in {{ locationName }}</span>
        </div>
    </div>
</template>
<script>
    let formatHelper = require('../../helpers/format').default

    export default {
        name: 'weather-current',
        data () {
            return {
                Perm: Perm,
                loading: true,
                name: this.value.name,
                temp: this.value.main.temp,
                icon: this.value.weather[0].icon,
            }
        },
        created () {
            this.loading = false
        },
        props: {
            value: {
                type: Object,
                default: function ()
                {
                    return {
                        name: null,
                        main: {
                            temp: null
                        },
                        weather: {
                            icon: null
                        },
                    }
                }
            },
        },
        computed: {
            locationName: function ()
            {
                return this.name
            },
            mainTemp: function ()
            {
                return formatHelper.round(this.temp, 0)
            },
            computedIcon: function ()
            {
                return "http://openweathermap.org/img/w/" + this.icon + '.png'
            },
        },
        components: {
        },
        methods: {
        }
    }
</script>
