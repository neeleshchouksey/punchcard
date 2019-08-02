<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div>
        <div style="margin: 30px">
            <h3>
                Really Delete this employee?

                <api-form action="/webapp/users" method="DEL" id="user-delete"
                    v-on:form-complete="formComplete"
                    v-model="userDelete">
                    <input class="primary-button btn" type="submit" value="Yes" />
                </api-form>
            </h3>
        </div>
    </div>
</template>
<script>
    // import User from '../api/user'
    import ApiForm from '../../components/ApiForm.vue'

    export default {
        name: 'user-delete',
        data () {
            return {
                Perm: Perm,
                userDelete: {
                    uniq_id: this.$route.params.user_id,
                },
            }
        },
        created () {
        },
        props: {
            renameMe: {
                type: String,
                default: null
            },
        },
        computed: {
        },
        components: {
            ApiForm
        },
        methods: {
            formComplete: function(data, response)
            {
                if (response.status == 200) {
                    this.$store.dispatch('deleteUser', data)
                    this.$store.dispatch('showAlertSuccess', {'title': 'User deleted', 'msg': null})

                    if (Perm.isAtLeast('admin')) {
                        this.$router.push('/client');
                    } else {
                        this.$router.push('/projects');
                    }
                }
            },
        }
    }
</script>
