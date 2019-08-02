<style lang="sass" scoped>
    @import '../../sass/_variables.scss';

    div.on, div.off {
        width: 100%;
        cursor: pointer;
        text-align: center;
        display: inline-block;
        padding: 3px 7px;
    }

    div.on {
        background: $theme-gold;
        border-color: $theme-gold;
        color: #111;
    }

    div.off {
        background: lighten($bg-monotone, 10%);
        color: #888;
    }
</style>
<template>
    <div @click="emitToggle" :class="{'on': value, 'off': !value}">
        {{ toggleText }}
    </div>
</template>
<script>
    export default {
        name: 'toggle-switch',
        data () {
            return {
            }
        },
        created () {
        },
        props: {
            value: {
                type: Boolean,
                default: false
            },
            onText: {
                type: String,
                default: 'On'
            },
            offText: {
                type: String,
                default: 'Off'
            },
        },
        computed: {
            toggleText: function() {
                return this.value ? this.onText : this.offText;
            }
        },
        components: {
        },
        methods: {
            emitToggle: function(event) {
                this.$emit('input')
            }
        }
    }
</script>
