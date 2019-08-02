<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div class="col-sm-8">
        <form-input name="jdoc.emerContact.name" :edit_mode="edit_mode" v-model="data.name">
            Name
        </form-input>

        <form-input name="jdoc.emerContact.relation" :edit_mode="edit_mode" v-model="data.relation">
            Relation
        </form-input>

        <form-input name="jdoc.emerContact.homeNumber" :edit_mode="edit_mode" v-model="data.homeNumber">
            Home Phone
        </form-input>

        <form-input name="jdoc.emerContact.workNumber" :edit_mode="edit_mode" v-model="data.workNumber">
            Work Phone
        </form-input>

        <form-input name="jdoc.emerContact.mobileNumber" :edit_mode="edit_mode" v-model="data.mobileNumber">
            Mobile Phone
        </form-input>

        <form-input name="jdoc.emerContact.email" :edit_mode="edit_mode" v-model="data.email">
            Email
        </form-input>
      </div>
</template>
<script>
    import FormInput from '../../components/ReactiveFormInput.vue';

    export default {
        name: 'user-jdoc-emercontact',
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
                        name: null,
                        relation: null,
                        homeNumber: null,
                        workNumber: null,
                        mobileNumber: null,
                        email: null
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

