<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        table {
            margin: 15px 0;
            width: 100%;
            border: 1px solid lighten($bg-monotone, 15%);
            border-radius: 15px;
            -moz-border-radius: 15px;
            -webkit-border-radius: 15px;
        }

        thead {

            font-weight: bold;

            tr {
                background: lighten($bg-monotone, 10%);

                td {
                    padding: 15px;
                }
            }

        }

        tbody td {
            padding: 10px;
        }
    }
</style>
<template>
    <div>
        <loader :loading="loading"></loader>

        <div v-show="!loading">
            <table class="table table-striped" style="border-radius: 15px;">
                <thead>
                    <tr>
                        <td>Name</td>
                        <td>Phone</td>
                        <td>Email</td>
                        <td>Scanner Access</td>
                        <td>Role</td>
                        <td>Company</td>
                        <td></td>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="user in users">
                        <td><router-link :to="{ path: '/user/' + user.uniq_id + '/details'}">{{ user.name }}</router-link></td>
                        <td>{{ user.mobileNumber }}</td>
                        <td>{{ user.email }}</td>
                        <td><toggle-switch on-text="Access" off-text=" None " :status="hasScannerAccess(user, project)"></toggle-switch></td>
                        <td>{{ user.role }}</td>
                        <td></td>
                        <td>
                            <span @click="removeFromProject(user, project)" class="glyphicon glyphicon-remove-sign"></span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>
<script>
    import ToggleSwitch from './ToggleSwitch.vue';

    export default {
        data () {
            return {
                loading: true
            }
        },
        created () {
            this.loading = false
        },
        computed: {
        },
        props: {
            project: {
                type: Object,
                default: {
                }
            },
            users: {
                type: Array,
                default: function () {
                    return []
                }
            },
        },
        components: {
            ToggleSwitch
        },
        methods: {
            hasScannerAccess(user, project) {
                if (user.permissions.scanner === undefined) {
                    return false;
                }

                return (_.indexOf(user.permissions.scanner, project.id) > -1);
            },
            removeFromProject(user, project) {
            }
        }
    }
</script>
