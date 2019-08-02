<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div>
        <h1>Error</h1>

        <div>{{ problem }}</div>
    </div>
</template>
<script>
    // import User from '../api/user'

    export default {
        name: 'problem',
        data () {
            return {
               problem: "Unknown error"
            }
        },
        created () {
        },
        methods: {
        }
    }
</script>
