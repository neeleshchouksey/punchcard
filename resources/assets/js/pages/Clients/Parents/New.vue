<style lang="sass" scoped>
</style>
<template>
    <div>
        <h1>Add Parent Client</h1>

        <ajax-form id="client-new-form" method="POST" action="/webapp/clients/parent"
            v-model="client"
            v-on:form-complete="formComplete"
            v-permission="'ParentAdd'">

            <h4>Company Information</h4>

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
    import ClientForm from '../ClientForm.vue'
    import AjaxForm from '../../../components/Form.vue'
    import SecureImg from '../../../components/SecureImg.vue';

    export default {
        name: 'parent-new',
        data () {
            return {
                client: {
                    fein: '',
                    name: '',
                    subdomain: '',
                    dba: '',
                    address: '',
                    city: '',
                    state: '',
                    zip: '',
                    phone: '',
                    fax: '',
                    website: '',
                    status: 'active',
                    image : ''
                },
                edit_mode: true
            }
        },
        created () {
        },
        computed: {
        },
        methods: {
            formComplete: function(response) {
                if (response.status == 200) {

                    this.edit_mode = false;

                    this.$store.dispatch('showAlertSuccess',
                    {
                        title: "Success",
                        msg: 'Client added, please add at least one user, preferably a clientadmin role'
                    });

                    this.$router.push({name: 'child-employees', params: {uniq_id: response.data.data.uniq_id}});
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
