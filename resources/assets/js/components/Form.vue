<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div>
        <form :id="id" :name="id" :action="action" :method="method" @submit.prevent="handleSubmit">
            <slot></slot>
        </form>
    </div>
</template>
<script>
    let formHelper = require ('../helpers/form.js').default;

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
                        case 'DELETE': return true
                        case 'GET': return true
                        case 'POST': return true
                        case 'PUT': return true

                        default: return false
                    }
                }
            }
        },
        components: {
        },
        methods: {
            handleSubmit: function (e) {
                formHelper.getFormData(e.target).then((data) => {

                    let result = Api[this.method.toLowerCase()](this.action, data).then((response) => {
                        this.$emit('form-complete', response);
                    });

                }).catch((data) => {
                });
            },
        }
    }
</script>
