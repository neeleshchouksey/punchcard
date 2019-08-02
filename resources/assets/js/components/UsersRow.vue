<style lang="sass" scoped>
    div {
    }
</style>
<template>
    <tr>
        <td>
            <span v-if="user.uniq_id">
                <router-link :to="{ path: '/user/' + user.uniq_id + '/details'}">{{ user.first_name }} {{ user.last_name }}</router-link>
            </span>
            <span v-else>
                {{ user.first_name }} {{ user.last_name }}
            </span>
        </td>
        <td><formatter mask="phone" v-model="user.mobileNumber"></formatter></td>
        <td>
            <span>{{ user.email }}</span>
        </td>
        <td>
            <toggle-switch
                v-on:input="toggleScannerAccess(user, project)"
                on-text="Access"
                off-text=" None "
                v-model="hasScannerAccess">
            </toggle-switch>
        </td>
        <td>{{ user.role }}</td>
        <td>
            <router-link :to="{ path: '/child/' + user.client_uniq_id + '/summary'}">{{ user.client_name }}</router-link>
        </td>
        <td>
            <span v-if="user.uniq_id" @click="removeFromProject(user, project, $event)"
                class="fa-center fa fa-2x fa-times pointer">
            </span>
        </td>
    </tr>
</template>
<script>
    import ToggleSwitch from './ToggleSwitch.vue';
    import Formatter from './Formatter.vue';
    import UX from '../helpers/UX';

    export default {
        data () {
            return {
                local_user: this.user,
            }
        },
        mounted () {
        },
        created () {
            this.routes = Api.getRoutes('webapp-projects');
        },
        destroyed () {
        },
        computed: {
            hasScannerAccess() {
                if (typeof this.local_user.permissions === 'undefined') {
                    return false;
                }

                if (typeof this.local_user.permissions.scanner === 'undefined') {
                    return false;
                }

                let access = (_.indexOf(this.local_user.permissions.scanner, this.project.id) > -1)
                return access
            },
        },
        props: {
            project: {
                type: Object,
                default: () => {
                    return {
                        name: null,
                        uniq_id: null,
                        id: null
                    }
                }
            },
            user: {
                type: Object,
                default: () => {
                    return {
                        permissions: {
                            scanner: []
                        },
                        name: null,
                        first_name: null,
                        last_name: null,
                        uniq_id: null,
                        id: null
                    }
                }
            },
        },
        components: {
            ToggleSwitch,
            Formatter
        },
        methods: {
            toggleScannerAccess(user, project) {
                this.$store.dispatch('toggleScannerAccess', [user, project]).then((result) => {
                    if (result.response.status == 200) {

                    }
                });
            },
            removeFromProject(user, project, event) {

                if (!confirm('Really remove user from this project?')) {
                    return;
                }

                if (UX.alreadyClicked(event)) {
                    return;
                }

                UX.setTarget(event)
                  .addClicked()
                  .removeTimes()
                  .addSpin();

                let data = {
                    'project_uniq_id': project.uniq_id,
                    'user_uniq_id': user.uniq_id
                }

                this.routes.project_users.put(data).then((result) => {
                    this.$store.dispatch('showAlertSuccess', {
                      title: result.data.message,
                      msg: null
                    })
                    UX.setTarget(event).removeSpin().addBan()
                    Api.delete(project.uniq_id)
                    Api.delete(user.uniq_id)
                    Api.delete('project-users-' + project.uniq_id)
                });
            },
        }
    }
</script>
