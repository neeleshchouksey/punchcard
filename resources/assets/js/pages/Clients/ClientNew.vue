<style lang="sass" scoped>
</style>
<template>
    <div>
        <h1>Add New Child Company</h1>

        <ajax-form id="client-new-form" method="POST" action="/webapp/clients"
            v-model="client"
            v-on:form-complete="formComplete"
            v-permission="'ClientAdd'">

            <h4>Company Information</h4>

            <input type="hidden" name="parent_uniq_id" v-model="getUniqIdIfNeeded" />

            <div class="row">
              <div class="col-sm-3">
                  <secure-img :edit_mode="edit_mode"
                  :src="logo" className="img-rounded img-responsive"
                  title="click to change logo" @image-uploaded="handleImageUpload">
                </secure-img>
              </div>
              <input type="hidden" name="image" v-model="client.image" />
              <client-form class="col-sm-9" :client="client" :edit_mode="edit_mode"></client-form>
            </div>


            <div>
                <input class="primary-button btn" type="submit" value="Add" />
            </div>
        </ajax-form>
    </div>
</template>
<script>
    import ClientForm from './ClientForm.vue'
    import AjaxForm from '../../components/Form.vue'
    import SecureImg from '../../components/SecureImg.vue';
    export default {
        name: 'client-new',
        data () {
            return {
                uniq_id: this.$route.params.uniq_id,
                client: {
                  image : '',
                    fein: '',
                    dba: '',
                    name: '',
                    address: '',
                    city: '',
                    state: '',
                    zip: '',
                    phone: '',
                    fax: '',
                    website: '',
                    status: 'active'
                },
                edit_mode: true
            }
        },
        created () {
        },
        computed: {
            getUniqIdIfNeeded: function ()
            {
                // superadmin: return null
                return this.uniq_id;
            }
        },
        methods: {
            formComplete: function(response) {
                if (response.status == 200) {

                    this.edit_mode = false;

                    this.$store.dispatch('showAlertSuccess',
                    {
                        title: "Success",
                        msg: response.data.message
                    });

                    // for superadmin creating new parent this.$router.push({name: 'client-main', params: {uniq_id: response.data.data.uniq_id}});
                    this.$router.push({name: 'child-summary', params: {uniq_id: response.data.data.uniq_id}});
                } else {
                    this.$store.dispatch('showAlertFail',
                    {
                        title: "There was a problem",
                        msg: response.data.message
                    });
                }
            },
            handleImageUpload(imgInfo, imgData) {
              let imgSplit = imgData.split(',', 2);
              this.client.image = imgSplit[1];
            },
        },
        components: {
            AjaxForm,
            ClientForm,
            SecureImg
        }
    }
</script>

