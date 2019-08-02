<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    .dismiss {
        cursor: pointer;
        position: absolute;
        right: 0;
        top: 0;
        padding: 10px;
        margin: 10px;
    }
    .alert {
        width: 40%;
        border-radius: 0;
        border-width: 5px;
        margin: 10px;
        .row {
            margin: 0;
            .header {
                font-size: 1.25em;
                font-weight: 800;
            }
        }
    }
</style>
<template>
    <div>
        <alert class='card' v-show="show" placement="top" :duration="duration" :type="type">
            <div class="row">
                <div class="header">
                    {{ title }}
                </div>
                <div class='message'>
                    {{ msg }}
                </div>
            </div>
            <div class="dismiss" title="Click to dismiss" @click="dismissAlert">
                <i class="fa fa-times" aria-hidden="true"></i>
            </div>
        </alert>
    </div>
</template>
<script>
    import alertStore from '../stores/alert';
    Vue.component('alert', require('vue-strap').alert);

    export default {
        data () {
            return {
                newshow: alertStore.state.show,
                newtitle: alertStore.state.title,
                newmsg: alertStore.state.msg,
                newtype: alertStore.state.type
            }
        },
        created () {
        },
        computed: {
            title () {
                if(alertStore.state.title){
                  setTimeout(function () { this.dismissAlert() }.bind(this), 5000)
                }
                return alertStore.state.title;
            },
            msg () {
              if(alertStore.state.msg){
                setTimeout(function () { this.dismissAlert() }.bind(this), 5000)
              }
              return alertStore.state.msg;
            },
            type () {
                return alertStore.state.type;
            },
            show () {
                return alertStore.state.show;
            },
            duration () {
                return alertStore.state.duration;
            }
        },
        methods: {
            dismissAlert: function () {
                this.$store.dispatch('dismissAlert', {title: '...'});
            },
        }
    }
</script>
