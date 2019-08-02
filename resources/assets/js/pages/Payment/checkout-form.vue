<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {
    }
</style>
<template>
    <div>
      <form-input name="first_name" :edit_mode="edit_mode" v-model="checkout.first_name">
         First Name
      </form-input>

      <form-input name="last_name" :edit_mode="edit_mode" v-model="checkout.last_name">
         Last Name
      </form-input>

      <form-input name="billing_address.phone" :edit_mode="edit_mode" v-model="checkout.billing_address.phone">
         Phone Number
      </form-input>

      <form-input name="billing_address.line1" :edit_mode="edit_mode" v-model="checkout.billing_address.line1">
         Billing Address
      </form-input>

      <form-input name="billing_address.postal_code" :edit_mode="edit_mode" v-model="checkout.billing_address.postal_code">
         Postal Code
      </form-input>

      <form-input name="billing_address.city" :edit_mode="edit_mode" v-model="checkout.billing_address.city">
         City
      </form-input>

      <form-input name="billing_address.state" :edit_mode="edit_mode" v-model="checkout.billing_address.state">
         State
      </form-input>

    <!--  <form-input name="billing_address.country_code" :edit_mode="edit_mode" v-model="checkout.billing_address.country_code">
         Country
      </form-input> -->

      <form-dropdown name="type" :edit_mode="edit_mode"
          v-model="checkout.type"
          :options="cardTypeOptions">
         Card Type
       </form-dropdown>

      <form-input name="number" :edit_mode="edit_mode" v-model="checkout.number">
         Card Number
      </form-input>

      <form-input name="cvv2" :edit_mode="edit_mode" v-model="checkout.cvv2">
         Security Code
      </form-input>

      <form-dropdown name="expire_month" :edit_mode="edit_mode"
          v-model="checkout.expire_month"
          :options="monthOptions">
         Expiration Month
      </form-dropdown>

      <form-dropdown name="expire_year" :edit_mode="edit_mode"
          v-model="checkout.expire_year"
          :options="yearOptions">
         Expiration Year
       </form-dropdown>

    </div>
</template>
<script>
    import FormInput from '../../components/ReactiveFormInput.vue';
    import FormDropdown from '../../components/FormSelect.vue';


    export default {
        name: 'checkout-form',
        data () {
            return {
                monthOptions: [
                    {text: '1', value: '1' },
                    {text: '2', value: '2' },
                    {text: '3', value: '3' },
                    {text: '4', value: '4' },
                    {text: '5', value: '5' },
                    {text: '6', value: '6' },
                    {text: '7', value: '7' },
                    {text: '8', value: '8' },
                    {text: '9', value: '9' },
                    {text: '10', value: '10' },
                    {text: '11', value: '11' },
                    {text: '12', value: '12' },
                ],
                yearOptions: [
                    // {text: '2017', value: '2017' },
                    {text: '2018', value: '2018' },
                    {text: '2019', value: '2019' },
                    {text: '2020', value: '2020' },
                    {text: '2021', value: '2021' },
                    {text: '2022', value: '2022' },
                    {text: '2023', value: '2023' },
                    {text: '2024', value: '2024' },
                    {text: '2025', value: '2025' },
                    {text: '2026', value: '2026' },
                    {text: '2027', value: '2027' },
                    {text: '2028', value: '2028' },
                ],
                cardTypeOptions: [
                    // {text: 'American Express', value: 'amex' },
                    {text: 'Discover', value: 'discover' },
                    {text: 'MasterCard', value: 'mastercard' },
                    {text: 'Visa', value: 'visa' },
                    {text: 'Diners Club', value: 'diners-club' },
                    //{text: 'JCB', value: 'jcb' },
                    {text: 'Laser', value: 'laser' },
                    {text: 'Maestro', value: 'maestro' },
                    {text: 'UnionPay', value: 'unionpay' },
                    {text: 'Visa Electron', value: 'visa-electron' },
                    {text: 'Dankort', value: 'dankort' },

                ],
            }
        },
        created () {
        },
        props: {
            edit_mode: {
                type: Boolean,
                default: null
            },
            checkout: {
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
