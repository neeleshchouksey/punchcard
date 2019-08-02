<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <form action="#" name="form-settings" id="form-settings">
        <h1>Settings</h1>

        <label>
            <input v-model="url" type="text" placeholder="enter url starting with http..." />
        </label>

        <div>
            <input type="submit" value="Save" @click.prevent="saveSettings" />
        </div>
    </form>
</template>
<script>
    export default {
        name: 'settings',
        data () {
            return {
                scheme: ''
            }
        },
        created () {
        },
        methods: {
            saveSettings: function () {
                localStorage.setItem('url', this.url);
                Api.refresh();
            }
        }
    }
</script>
