<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        #map {
            height: 500px;
        }
    }
</style>
<template>
    <div>
        <div id="map"></div>
    </div>
</template>
<script>
    export default {
        name: 'map',
        data () {
            return {
                fenceExists: false,
            }
        },
        created () {
            this.map_lib = 'https://maps.googleapis.com/maps/api/js?key=';
            this.map_key = 'AIzaSyDxjOnSHmNUO0jcepwRsDD1-FLOBTViNvA';
            this.map_callback = '&callback=initMap';

            window.initMap = () => {

                this.map = new google.maps.Map(document.getElementById('map'), {
                    zoom: this.mapZoom,
                    center: this.mapCenter
                });

                this.marker = new google.maps.Marker({
                    position: this.mapCenter,
                    draggable: true,
                    map: this.map
                });

                let editingMarkerLocation = (mev) => {
                    this.$emit('marker-changed', this.marker.getPosition());
                }

                google.maps.event.addListener(this.marker, 'dragend', editingMarkerLocation);
                this.mapUpdater();
                this.$emit('googlemapsinit');
            }

            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.id = 'google-fence-map';
            script.src = this.map_lib + this.map_key + this.map_callback;
            document.body.appendChild(script);
        },
        destroyed () {
            $('#google-fence-map').remove()
            window.google = {}
        },
        props: {
            point: {
                type: String,
                default: null
            },

            fence: {
                type: Array,
                default: null
            },

            showFence: {
                type: Boolean,
                default: false,
            },

            mapCenter: {
                type: Object,
                default: function ()
                {
                    return {
                        "lat": 41,
                        "lng": -81,
                    };
                }
            },

            mapZoom: {
                type: Number,
                default: 12,
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
        },
        watch: {
            fence: function () {
                this.mapUpdater();
            },

            showFence: function () {
                this.mapUpdater();
            },

        },
        methods: {
            mapUpdater: function()
            {
                if (this.showFence && !this.fenceExists)
                {
                    this.localFence = this.fence;
                    this.polyFenceMap = new google.maps.Polygon({
                      paths: this.localFence,
                      center: this.mapCenter,
                      strokeColor: '#800',
                      strokeOpacity: 0.8,
                      strokeWeight: 3,
                      fillColor: '#f00',
                      editable: true,
                        draggable: true,
                        geodesic: true,
                      fillOpacity: 0.15
                    });

                    this.polyFenceMap.setMap(this.map);
                    this.fenceExists = true;

                } else if (!this.showFence && this.fenceExists) {
                    this.polyFenceMap.setMap(null);
                    this.localFence = null;
                    this.fenceExists = false;
                    return;
                } else {
                    return;
                }


                //
                // EVENTS
                //
                let deleteNode = (mev) => {
                    if (mev.vertex != null && this.polyFenceMap.getPath().getLength() > 3) {
                        this.polyFenceMap.getPath().removeAt(mev.vertex);
                        this.$emit('shape-changed', this.polyFenceMap.getPath());
                    }
                }

                google.maps.event.addListener(this.polyFenceMap, 'rightclick', deleteNode);

                let insertNode = (mev) => {
                    if (mev.latLng != null) {
                        this.polyFenceMap.getPath().push(mev.latLng);
                        this.$emit('shape-changed', this.polyFenceMap.getPath());
                    }
                }

                google.maps.event.addListener(this.polyFenceMap, 'click', insertNode);

                let editingShape = (mev) => {
                    this.$emit('shape-changed', this.polyFenceMap.getPath());
                }

                google.maps.event.addListener(this.polyFenceMap, 'dragend', editingShape);
                google.maps.event.addListener(this.polyFenceMap.getPath(), 'set_at', editingShape);
                google.maps.event.addListener(this.polyFenceMap.getPath(), 'insert_at', editingShape);

            }
        }
    }
</script>
