<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        margin-top: 1px;
        margin-bottom: 1px;
    }


</style>
<template>
    <div class="row profile-item">
        <div v-if="slotNotEmpty">
            <label class="col-sm-3 profile-item-label">
                <slot></slot>
            </label>
        </div>

        <div v-if="!edit_mode"  class="input-like profile-item-input" :class="{ 'col-sm-9': slotNotEmpty, 'col-sm-12': !slotNotEmpty}">
            {{ localData }}
        </div>

        <div v-if="edit_mode">
            <div :class="{'col-sm-9 profile-item-input': slotNotEmpty, 'col-sm-12 profile-item-input': !slotNotEmpty}" style="display: table;">
                <input type="text" :placeholder="placeholder" :name="name" v-model="localData" :disabled="disabled" style="display: table-cell;">
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'form-input',
        data () {
            return {
            }
        },
        mounted () {
        },
        props: {
            disabled: {
                type: Boolean,
                default: false
            },
            placeholder: {
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
            slotNotEmpty: function () {

                if (typeof this.$slots === 'undefined') {
                    return null;
                }

                if (typeof this.$slots.default === 'undefined') {
                    return null;
                }

                if (typeof this.$slots.default[0] === 'undefined') {
                    return null;
                }

                if (typeof this.$slots.default[0].text === 'undefined') {
                    return null;
                }

                return this.$slots.default[0].text
            },
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
