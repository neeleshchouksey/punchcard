<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {
    }
</style>

<template>
    <div>
        <form-input name="fein" :edit_mode="edit_mode" v-model="client.fein">
           FEIN<span style="color:red;">*</span>
        </form-input>

        <form-input name="name" :edit_mode="edit_mode" v-model="client.name">
           Name<span style="color:red;">*</span>
        </form-input>

        <form-input name="dba" :edit_mode="edit_mode" v-model="client.dba">
           DBA
        </form-input>

        <form-input v-permission="'ClientSubdomain'" name="subdomain" :edit_mode="edit_mode" v-model="client.subdomain">
           Subdomain<span style="color:red;">*</span>
        </form-input>

        <form-input name="address" :edit_mode="edit_mode" v-model="client.address">

           Address<span style="color:red;">*</span>
        </form-input>

        <form-input name="city" :edit_mode="edit_mode" v-model="client.city">
           City<span style="color:red;">*</span>
        </form-input>

        <form-input name="state" :edit_mode="edit_mode" v-model="client.state">
           State<span style="color:red;">*</span>
        </form-input>

        <form-input name="zip" :edit_mode="edit_mode" v-model="client.zip">
           Zip<span style="color:red;">*</span>
        </form-input>

        <form-input name="phone" :edit_mode="edit_mode" v-model="client.phone">
           Phone<span style="color:red;">*</span>
        </form-input>

        <form-input name="fax" :edit_mode="edit_mode" v-model="client.fax">
           Fax
        </form-input>

        <form-input name="website" :edit_mode="edit_mode" v-model="client.website">
           Website
        </form-input>
        <form-dropdown name="status" :edit_mode="edit_mode" style="text-transform: capitalize;"
            v-model="client.status" v-if="client.status"
            v-permission="'showClientStatusField'" :options="statusOptions">
           Status
        </form-dropdown>
    </div>
</template>
<script>
    import FormInput from '../../components/ReactiveFormInput.vue';
    import FormDropdown from '../../components/FormSelect.vue';


    export default {
        name: 'client-form',
        data () {
            return {
                statusOptions: [
                    {text: 'Active', value: 'active' },
                    {text: 'Inactive', value: 'inactive' }
                ]
            }
        },
        created () {
            //v-if="client.status && client.uniq_id != User.profile().client.uniq_id"
        },
        props: {
            edit_mode: {
                type: Boolean,
                default: null
            },
            client: {
                type: Object,
                default: {
                }
            },
        },
        computed: {
        },
        components: {
            FormInput,
            FormDropdown
        },
        methods: {
        }
    }
</script>
