<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
    @import '../../../sass/app.bs.css';
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
        .row-float {
            float: left;
            width: 100%;
            &:last-child > div {
                float: left;
            }
        }
    }
</style>
<template>
    <div>
            <api-form id="user-update-form" method="PUT" action="/webapp/users" v-model="user" v-on:form-complete="formComplete">
                <div class="row">
                    <user-detail v-if="user.jdoc"
                        v-on:input="validateInput" v-model="user"
                        :role-options="roleOptions"
                        type="adminEditing" :edit_mode="edit_mode">
                    </user-detail>
                </div>

                <div class="row">
                    <div class="row-float" v-if="showEditButton()">
                        <button class="primary-button btn" @click.prevent="enterEditMode">Edit</button>
                    </div>

                    <div class="row-float" v-if="showCancelButton()">
                        <button class="primary-button btn" @click.prevent="exitEditMode">Cancel</button>
                    </div>

                    <div class="row-float" v-if="showSaveButton()">
                        <input class="primary-button btn" type="submit" value="Save" />
                    </div>

                    <div v-if="user.uniq_id" class="row-float">
                        <router-link :to="{name: 'user-password-reset', params: { user_id: user.uniq_id}}">
                            <button class="primary-button btn">Reset Password</button>
                        </router-link>
                    </div>
                </div>
            </api-form>

        <div class="row" v-if="user.uniq_id" style="margin-top: 50px;">
            <div v-permission="'Impersonate'">
                <button class="btn btn-danger" @click.prevent="Imp(user, $event)" v-if="ImpersonatableRole">Login As</button>
            </div>
        </div>
    </div>
</template>
<script>
    import ApiForm from '../../components/ApiForm.vue'
    import UserDetail from '../../components/UserDetail.vue'
    import Config from '../../config'

    export default {
        name: 'user-details',
        data () {
            return {
                roleOptions: [],
                user: {
                    uniq_id: null,
                },
                edit_mode: false
            }
        },
        created () {
            this.uniq_id = this.$route.params.user_id;

            let routes     = Api.getRoutes('user-admin');
            routes.user.get(this.uniq_id).then((user) => {
                this.user = user;
            }).catch((response) => {
                this.$store.dispatch('showAlertFail', {title: 'Access Error', msg: response.statusText});
            });
        },
        computed: {
            ImpersonatableRole: function () {
                return (this.user.status == 'active' && (this.user.role == 'admin' || this.user.role == 'clientadmin'));
            },
            /*roleOptions: function ()
            {
                return Config.roleOptions('editing', this.user)

            }*/
        },

        components: {
            ApiForm,
            UserDetail
        },

        methods: {
            Imp: function (user, event) {
                this.$store.dispatch("imp", user);
            },
            formComplete: function(user, response) {
                if (response.status == '200') {
                    this.edit_mode = false
                    Api.delete(user.uniq_id)

                    this.$store.dispatch('showAlertSuccess', {title: 'Success', msg: 'User updated'});
                }
            },
            showCancelButton: function () {
                return this.edit_mode
            },
            showEditButton: function () {
                return !this.edit_mode
            },
            showSaveButton: function () {
                return this.edit_mode
            },
            enterEditMode: function ()
            {
                this.roleOptions = Config.roleOptions('editing', this.user);
                this.edit_mode = true;
            },
            exitEditMode: function ()
            {
                this.edit_mode = false;
            },
            validateInput: function(data)
            {
            }
        }
    }
</script>
