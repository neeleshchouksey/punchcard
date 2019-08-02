<style lang="sass" scoped>
</style>
<template>
    <span>{{ valueOutput }}</span>
</template>
<script>
    import formatHelper from '../helpers/format';

    export default {
        name: 'formatter-component',
        data () {
            return {
            }
        },
        created () {
        },
        props: {
            mask: {
                type: String,
                default: null
            },
            value: {
                type: String,
                default: null
            },
        },
        computed: {
            valueOutput: function()
            {
                switch(this.mask) {
                    case 'phone':
                        return this.phone();
                        break;
                }
            },
        },
        components: {
        },
        methods: {
            phone: function () {
                return formatHelper.phone(this.value);
            },
        }
    }
</script>
