<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {
        margin-top: 20px;
    }
</style>
<template>
    <div>
        <label for="badge_number">
            Please enter a badge number:
        </label>

        <input v-model="badge_id" id="badge_id_input"/>
        <button class='btn material' @click="savePunch('post')">Punch In</button>
        <button class='btn material' @click="savePunch('put')">Punch Out</button>
    </div>
</template>
<script>
    export default {
        name: 'project-virtualgate',
        data () {
            return {
                Perm: Perm,
                badge_id: null,
                project_id: this.$route.params.project_id
            }
        },
        created () {
        },
        methods: {
            savePunch: function(method) {

                if (!this.badge_id) {
                    this.$store.dispatch('showAlertFail', { title: "Error", msg: 'Please enter a badge ID'});
                    return
                }

                let data = {
                    'method': method,
                    'badge_id': this.badge_id,
                    'project_uniq_id': this.project_id
                }

                this.$store.dispatch('punch', data).then(response => {
                    if (typeof response !== 'undefined') {
                        this.$store.dispatch('showAlertSuccess', { title: "Punch Result", msg: response.body.message });
                        this.badge_id = "";
                        $('#badge_id_input').focus();
                    }
                })
            }
        }
    }
</script>
