<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div class="col-sm-8">
        <form-input name="jdoc.address.address1" :edit_mode="edit_mode" v-model="data.address1">
            Address 1
        </form-input>

        <form-input name="jdoc.address.address2" :edit_mode="edit_mode" v-model="data.address2">
            Address 2
        </form-input>

        <form-input name="jdoc.address.city" :edit_mode="edit_mode" v-model="data.city">
            City
        </form-input>

        <form-input name="jdoc.address.state" :edit_mode="edit_mode" v-model="data.state">
            State
        </form-input>

        <form-input name="jdoc.address.zip" :edit_mode="edit_mode" v-model="data.zip">
            Zip
        </form-input>
      </div>
    </div>
    </div>
</template>
<script>
    import FormInput from '../../components/ReactiveFormInput.vue';

    export default {
        name: 'user-jdoc-address',
        data () {
            return {
                /*
                data: {
                  type: Object,
                  default: function () {
                    return {
                        address1: null,
                        address2: null,
                        city: null,
                        state: null,
                        zip
                    }
                  }
               },
                */
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
                        address1: null,
                        address2: null,
                        city: null,
                        state: null,
                        zip: null
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

