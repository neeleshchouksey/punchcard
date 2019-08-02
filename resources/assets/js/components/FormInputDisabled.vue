<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        label {
            text-align: left;
        }

    }
</style>
<template>
    <div>
        <div v-if="!edit_mode">
            <label class="col-sm-2">{{ label }}:</label>
            <div class="col-sm-10">
                {{ data }}
            </div>
        </div>

        <div v-if="edit_mode">
            <label class="col-sm-2">{{ label }}:</label>
            <div class="col-sm-10">
                <input :name="name" v-model="data" disabled>
            </div>
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
            label: {
                type: String,
                default: null
            },
            name: {
                type: String,
                default: null
            },
            data: {
                type: String,
                default: null
            },
            edit_mode: {
                type: Boolean,
                default: false
            }
        },
        computed: {
        },
        components: {
        },
        methods: {
        }
    }
</script>
