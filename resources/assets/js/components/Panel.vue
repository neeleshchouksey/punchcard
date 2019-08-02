<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

        h3 {
            text-align: center;
        }

        .panel-body {
            font-size: 120%;
            border: 1px solid $input-default-border;
            text-align: center;
            padding: 10px;
            vertical-align: middle;
            border-radius: 5px;
        }

        .panel-top {
            border: 0px;
            margin-bottom: 15px;
            min-height: 15px;
        }

        .panel-default {
            border: 0px;
            margin: 2px;
        }
    }
</style>
<template>
    <div v-bind:style="css.panelEntire" class="panel-default col-sm-12">
        <div class="panel-top">
            <h3 v-if="title" class="panel-title">&nbsp;{{ title }}&nbsp;</h3>
        </div>
        <div class="panel-body">
            <h2 v-bind:style="css.panelBody"><slot></slot></h2>
        </div>
    </div>
</template>
<script>
    export default {
        data () {
            return {
            }
        },
        props: {
            title: {
                type: String,
                default: null
            },
            css: {
                type: Object,
                default: function () {
                    return {
                        panelEntire: "",
                        panelHead: "",
                        panelBody: ""
                    }
                }
            }
        },
        created () {
        },
        methods: {
        }
    }
</script>
