<style lang="sass" scoped>
    @import '../../../../sass/_variables.scss';
    @import '../../../../sass/app.bs.css';
    div {
        h4 {
            padding-bottom: 5px;
            border-bottom: 2px solid #ccc;
        }

        h3 {
            margin: auto;
            margin-top: 25px;
            display: inline-block;
        }
    }
</style>
<template>
    <div>
        <h3>Add New Employee</h3>
        <api-form id="user-add-form" method="POST" action="/webapp/users"
            v-model="defaultUser" @form-complete="formComplete">
            <input type="hidden" v-if="defaultUser.client_uniq_id" v-model="defaultUser.client_uniq_id" />

            <user-detail v-if="defaultUser"
                v-model="defaultUser"
                :role-options="roleOptions"
                type="adminEditing"
                :edit_mode="true">
            </user-detail>

            <div class="row">
                <div class="col-xs-6">
                    <input class="primary-button btn" type="submit" value="Save" />
                </div>
                <div class="col-xs-6">
                </div>
            </div>
        </api-form>
    </div>
</template>
<script>
    import ApiForm from '../../../components/ApiForm.vue'
    import UserDetail from '../../../components/UserDetail.vue'
    import Config from '../../../config'
    let formHelper = require ('../../../helpers/form.js').default

    export default {
        name: 'child-user-add',
        data () {
            return {
                addFormSave: true,
                roleOptions: Config.roleOptions('addingToChild'),
                defaultUser: Config.defaultUserAddForm(this.$route.params.uniq_id),
            }
        },
        created () {
        },
        beforeDestroy: function () {

            if (this.addFormSave) {
                formHelper.getFormData(this.$el.querySelector('form')).then((data) => {
                    this.$store.dispatch('addFormSave', data)
                }).catch((data) => {
                })
            }
        },
        computed: {
        },
        components: {
            ApiForm,
            UserDetail
        },

        methods: {
            formComplete: function (user, response) {
                if(response.status == 200) {
                    Api.store(user.uniq_id, user)
                    this.addFormSave = false
                    this.$store.dispatch('addFormRemove')
                    this.$store.dispatch('showAlertSuccess', {title: response.data.message, msg: null})
                    this.$router.push({name: 'user-details', params: {user_id: response.data.data.uniq_id}})
                }
            },
        }
    }
</script>
