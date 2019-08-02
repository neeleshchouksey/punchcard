<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        width: calc(100%/3 - 40px);
        flex-grow: 0;
        flex-shrink: 1;
        margin-top: 25px;
        margin-bottom: 25px;
    }
</style>
<template>
    <div>
        <form :id="id" :name="id" :action="action" :method="method"
            @submit.stop.prevent="handleSubmit" @keydown.enter.stop.prevent="doNothing">
            <slot></slot>
        </form>
    </div>
</template>
<script>
    export default {
        data () {
            return {
            }
        },
        created () {
        },
        props: {
            value: {
                type: Object,
                required: true,
                default: {}
            },
            action: {
              type: String,
              required: true
            },
            method: {
                type: String,
                required: true,
                validator: function(value) {
                    switch(value.toUpperCase()) {
                        case 'POST': return true
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

                if (!this.value.file) {
                    this.$store.dispatch('showAlertFail', {title: 'Error ', msg: 'Please choose a valid file before submitting the form.'});
                    return false;
                }

                let formData = new FormData();
                formData.append('uniq_id', this.value.uniq_id);
                formData.append('file', this.value.file);

                let result = Api[this.method.toLowerCase()](this.action, formData, {
                    emulateHTTP: true,
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                }).then((response) => {
                    this.$emit('form-complete', this.value, response);
                }).catch(response => {
                });
            },
        }
    }
</script>
