<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div class="col-sm-8">
        <form-input name="jdoc.vehicle.carMake" :edit_mode="edit_mode" v-model="data.carMake">
            Car Make
        </form-input>
        <form-input name="jdoc.vehicle.carModel" :edit_mode="edit_mode" v-model="data.carModel">
            Car Model
        </form-input>
        <form-input name="jdoc.vehicle.driversLicenseNumber" :edit_mode="edit_mode" v-model="data.driversLicenseNumber">
            Drivers License Number
        </form-input>
        <form-input name="jdoc.vehicle.driversLicenseState" :edit_mode="edit_mode" v-model="data.driversLicenseState">
            Drivers License State
        </form-input>
        <form-input name="jdoc.vehicle.licPlateNumber" :edit_mode="edit_mode" v-model="data.licPlateNumber">
            License Plate Number
        </form-input>
        <form-input name="jdoc.vehicle.licPlateState" :edit_mode="edit_mode" v-model="data.licPlateState">
            License Plate State
        </form-input>
      </div>
    </div>
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
                        carMake: null,
                        carModel:null,
                        driversLicenseNumber:null,
                        driversLicenseState:null,
                        licPlateNumber:null,
                        licPlateState:null
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

