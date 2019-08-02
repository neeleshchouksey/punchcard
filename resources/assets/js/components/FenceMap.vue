<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div>
        <gmap
            @shape-changed="shapeChanged"
            @marker-changed="markerChanged"
            @googlemapsinit="foobar"
            :point="point"
            :map-center="mapCenter"
            :map-zoom="mapZoom"
            :show-fence="showFence" :fence="fence">
        </gmap>
    </div>
</template>
<script>
    import Gmap from "./Gmap.vue"

    export default {
        name: 'map',
        data () {
            return {
            }
        },
        created () {
        },
        props: {
            point: {
                type: String,
                default: null
            },

            showFence: {
                type: Boolean,
                default: false,
            },

            mapCenter: {
                type: Object,
                default: null
            },

            mapZoom: {
                type: Number,
                default: 12
            },

            fence: {
                type: Array,
                default: null
            },

            latitude: {
                type: Number,
                default: null
            },
            longitude: {
                type: Number,
                default: null
            },
        },
        computed: {
        },
        components: {
            Gmap
        },
        methods: {
            foobar: function () {

            },
            shapeChanged: function (newPath) {
                this.$emit('shape-changed', newPath);
            },
            markerChanged: function (newPosition) {
                this.$emit('marker-changed', newPosition);
            },
        }
    }
</script>
