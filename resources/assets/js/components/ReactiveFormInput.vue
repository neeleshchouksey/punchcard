<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        margin-top: 1px;
        margin-bottom: 1px;
    }
</style>
<template>
    <div class="row">
        <div v-if="slotNotEmpty">
            <label class="col-sm-3 input-like">
                <slot></slot>
            </label>
        </div>

        <div v-if="!edit_mode" class="input-like" :class="{ 'col-sm-9': slotNotEmpty, 'col-sm-12': !slotNotEmpty}">
            {{ localData }}
        </div>

        <div v-if="edit_mode">
            <div :class="{'col-sm-9': slotNotEmpty, 'col-sm-12': !slotNotEmpty}" style="display: table;">
                <input type="text" :placeholder="placeholder" :name="name"
                       v-model="localData"
                       v-on:input="onValueChange"
                    :disabled="disabled" style="display: table-cell;">

            </div>
        </div>
    </div>
</template>
<script>
    // @keyup="onValueChange"
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
            value: {
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
                return this.value
            }
        },
        components: {
        },
        methods: {
            onValueChange: function (event)
            {
                this.$emit('input', event.target.value);
            }
        }
    }
</script>
