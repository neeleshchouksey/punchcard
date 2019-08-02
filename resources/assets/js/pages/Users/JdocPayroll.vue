<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {
    }
</style>
<template>
    <div class="col-sm-8">
        <form-input name="jdoc.payroll.payrate" :edit_mode="edit_mode" v-model="data.payrate">
            Pay Rate
        </form-input>
      </div>
    </div>
    </div>
</template>
<script>
    import FormInput from '../../components/ReactiveFormInput.vue';

    export default {
        name: 'user-jdoc-payroll',
        data () {
            return {
            }
        },
        created () {
        },

        props: {
            edit_mode: false,
            data: {
                type: Object,
                default: function () {
                    return {
                        payrate: null
                    }
                }
            }
        },
        computed: {
        },
        components: {
            FormInput
        },
        methods: {
        }
    }
</script>


