<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div>
        <form :action="action" :method="method"
            :id="id" :name="id"
            @submit.stop.prevent="handleSubmit"
            @keydown.enter.stop.prevent="doNothing">
            <slot></slot>
        </form>
    </div>
</template>
<script>
    import UX from '../helpers/UX';
    let formHelper = require ('../helpers/form').default;

    export default {
        data () {
            return {
                loading: true
            }
        },
        created () {
            this.loading = false
        },
        props: {
            value: {
                type: Object,
                required: true,
                default: {}
            },
            id: {
              type: String,
              required: true
            },
            action: {
              type: String,
              required: true
            },
            'method': {
                type: String,
                required: true,
                validator: function(value) {
                    switch(value.toUpperCase()) {
                        case 'DEL': return true
                        case 'GET': return true
                        case 'POST': return true
                        case 'REALPOST': return true
                        case 'PUT': return true

                        default: return false
                    }
                }
            }
        },
        components: {
        },
        methods: {
            doNothing: function () {
                return false;
            },
            handleSubmit: function (e) {

                if (UX.alreadyClicked(event)) {
                    return;
                }

                UX.setTarget(e)
                  .addClicked();

                this.$emit('form-submitting', this.value);
                console.log(JSON.stringify(this.value));
                let result = Api[this.method.toLowerCase()](this.action, this.value).then((response) => {
                    console.log(response);
                    this.$emit('form-complete', this.value, response);
                    UX.removeClicked();
                }).catch(response => {
                    console.log('Error in submission');
                    UX.removeClicked();
                });
            },
        }
    }
</script>
