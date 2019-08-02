<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        margin-top: 1px;
        margin-bottom: 1px;
    }
    select {
        clear: both;
        float: none;
    }


</style>
<template>
    <div class="row profile-item">
        <label class="col-sm-3 profile-item-label">
            <slot></slot>
        </label>

        <div v-if="!edit_mode" class="col-sm-9 input-like profile-item-input">
            {{ localData }}
        </div>

        <div v-if="edit_mode" class="col-sm-9 profile-item-input">
            <select :name="name" v-model="localData" @change="optionChanged">
                <option v-for="option in options" v-bind:value="option.value">
                    {{ option.text }}
                </option>
            </select>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'form-select',
        data () {
            return {
                localData: this.value
            }
        },
        mounted () {

            /*
            if (this.edit_mode) {
                this.$refs.myDD.value = localData
            }
            */
        },
        props: {
            options: {
                type: Array,
                default: function () {
                    return []
                }
            },
            name: {
                type: String,
                default: null
            },
            value: {
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
            optionChanged: function(event)
            {
                let value = event.target.options[event.target.selectedIndex].value
                let text  = event.target.options[event.target.selectedIndex].text
                this.$emit('option-changed', {"text": text, "value": value});
                this.$emit('input', value);
            }
        }
    }
</script>
