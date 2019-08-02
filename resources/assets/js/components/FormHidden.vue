<style lang="sass" scoped>


</style>
<template>
    <div class="row profile-item">
        <label class="col-sm-3 profile-item-label">
            <slot></slot>
        </label>

        <div class="col-sm-9 input-like profile-item-input">
            {{ localData }}
            <input type="hidden" :name="name" v-model="localData">
        </div>
    </div>
</template>
<script>
    export default {
        name: 'form-hidden',
        data () {
            return {
            }
        },
        created () {
        },
        props: {
            name: {
                type: String,
                default: null
            },
            data: {
                type: String,
                default: null
            },
        },
        computed: {
            localData: function ()
            {
                return this.data
            }
        },
        components: {
        },
        methods: {
        }
    }
</script>
