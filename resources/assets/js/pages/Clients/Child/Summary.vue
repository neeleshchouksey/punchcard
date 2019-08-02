<style lang="sass" scoped>
    @import '../../../../sass/_variables.scss';
        h4 {
            padding-bottom: 5px;
            border-bottom: 2px solid #ccc;
        }

        h3 {
            margin: auto;
            margin-top: 25px;
            display: inline-block;
        }

        .btn {
            margin: 15px;
        }
</style>
<template>
    <div>
        <loader :loading="loading"></loader>

        <div v-show="!loading">
            <api-form id="child-update-form" method="PUT" action="/webapp/clients"
                v-model="client"
                @form-submitting="formSubmitting"
                @form-complete="mainFormComplete"

                v-on:form-complete="toggleEditMode">
                <h4>Current Company Profile Page</h4>
                <div class="row" style="margin-top: 50px;">
                    <div class="col-sm-4" v-if="client.logo">
                        <secure-img :edit_mode="edit_mode" :src="client.logo" className="img-rounded img-responsive" title="click to change logo" @image-uploaded="handleImageUpload"></secure-img>
                    </div>
                    <div class="col-sm-8">
                        <input type="hidden" name="subdomain" v-model="client.subdomain">

                        <form-hidden name="uniq_id" :data="client.uniq_id">
                            Company ID
                        </form-hidden>

                        <!-- <form-hidden name="subdomain" :data="client.subdomain">
                            Sub domainaaaaa
                        </form-hidden> -->

                        <div class="row profile-item">
                            <label class="col-sm-3 profile-item-label">
                                Sub domain
                            </label>

                            <div class="col-sm-9 input-like profile-item-input">
                                <a target="_blank" style="text-decoration: underline;":href="clientSubdomain">{{clientSubdomain}}</a>
                            </div>
                        </div>


                        <client-form :client="client" :edit_mode="edit_mode"></client-form>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12">

                        <div v-if="!edit_mode">
                            <button class="primary-button btn" @click.prevent="toggleEditMode">Edit</button>
                        </div>
                        <div v-else>
                            <button class="primary-button btn" @click.prevent="toggleEditMode">Cancel</button>

                            <input class="primary-button btn" type="submit" value="Save" />
                        </div>
                        <div v-if="!edit_mode">
                            <button class="primary-button btn" @click.prevent="deleteClient">Delete</button>
                        </div>

                    </div>
                </div>
            </api-form>


            <h4 style="margin-top: 50px;">Contact Information</h4>

            <div class="row" v-for="(contact, key, index) in computedContacts">
                <div class="col-sm-3">
                    {{ contact.name }}
                </div>
                <div class="col-sm-3">
                    <formatter mask="phone" v-model="contact.phone"></formatter>
                </div>
                <div class="col-sm-2">
                    {{ contact.job_title }}
                </div>
                <div class="col-sm-3">
                    {{ contact.email }}
                </div>
                <div class="col-sm-1">
                    <span @click="removeFromContacts(key, $event)"
                        class="fa-center fa fa-2x fa-times pointer">
                    </span>
                </div>
            </div>

            <div class="row">
                <api-form id="new-contact-form" method="POST" action="/webapp/clients/contact"
                    v-model="newContact"
                    v-on:form-complete="formCompleteNewContact">

                    <div class="col-sm-3">
                        <form-input v-model="newContact.data.name" :edit_mode="true" placeholder="Name"></form-input>
                    </div>
                    <div class="col-sm-3">
                        <form-input v-model="newContact.data.phone" :edit_mode="true" placeholder="Phone"></form-input>
                    </div>
                    <div class="col-sm-2">
                        <form-input v-model="newContact.data.job_title" :edit_mode="true" placeholder="Job Title"></form-input>
                    </div>
                    <div class="col-sm-3">
                        <form-input v-model="newContact.data.email" :edit_mode="true" placeholder="Email"></form-input>
                    </div>
                    <div class="col-sm-1">
                        <input class="primary-button btn" type="submit" value="Add" />
                    </div>
                </api-form>
            </div>
        </div>
    </div>
</template>
<script>
    let imageUpload = require ('../../../helpers/imageupload.js').default;
    import ClientForm from '../ClientForm.vue'
    import FormInput from '../../../components/ReactiveFormInput.vue'
    import Formatter from '../../../components/Formatter.vue'
    import FormHidden from '../../../components/FormHidden.vue';
    import ApiForm from '../../../components/ApiForm.vue'
    import SecureImg from '../../../components/SecureImg.vue';
    import UX from '../../../helpers/UX';
    let Config = require('../../../config.js').default;

    export default {
        name: 'child-summary',
        data () {
            return {
                loading: true,
                uniq_id: this.$route.params.uniq_id,
                clientSubdomain : '',
                client: {
                    uniq_id: null,
                    logo: null,
                    jdoc: null
                },
                edit_mode: false
            }
        },
        created () {
            this.newContact = this.defaultNewContact();

            if (this.$route.params.uniq_id !== null) {
                this.uniq_id = this.$route.params.uniq_id;
            }

            this.$store.dispatch('getClient', this.uniq_id).then((client) => {
                this.loading = false;
                this.projects = client.projects;
                this.users    = client.users;
                this.children = client.children;

                this.client = _.pick(client, ['name',
                                                'fein',
                                                'dba',
                                                'address',
                                                'city',
                                                'state',
                                                'zip',
                                                'phone',
                                                'fax',
                                                'website',
                                                'uniq_id',
                                                'subdomain',
                                                'status',
                                                'logo',
                                                'jdoc'
                                            ]);

                this.clientSubdomain = 'http://'+this.client.subdomain+'.'+Config.domainName.split('//')[1];
                this.client.subdomain = 'http://'+window.location.hostname+'/';
                if (Perm.ClientSubdomain()) {
                    this.client.subdomain = client.subdomain;
                }
            });

        },
        computed: {
            computedContacts: function () {

                if (this.client.jdoc === null) {
                    return null;
                }

                if (typeof this.client.jdoc.contacts === 'undefined') {
                    return null;
                }

                if (typeof this.client.jdoc.contacts.length <= 0)  {
                    return null;
                }

                return this.client.jdoc.contacts;
            },
        },
        methods: {
            deleteClient()
            {
                if (!confirm ('Really Delete this company?')) {
                    return;
                }

                this.$store.dispatch('deleteClient', {'uniq_id': this.uniq_id}).then((response) => {
                    this.$store.dispatch('showAlertSuccess', {title: response.data.message, msg: null})
                    this.$router.push('/client');
                });
            },

            defaultNewContact()
            {
                // This should not be reactive...
                return {
                   uniq_id: this.$route.params.uniq_id,
                   data:  {
                         name: '',
                        email: '',
                    job_title: '',
                        phone: '',
                   }
               }
            },

            removeFromContacts(id, event)
            {
                if (UX.alreadyClicked(event)) {
                    return
                }

                UX.setTarget(event)
                  .addClicked()
                  .removeTimes()
                  .addSpin();

                let data = {
                    "id": id,
                    "uniq_id": this.uniq_id
                }

                Api.put('/webapp/clients/contact', data).then(response => {
                    this.client.jdoc.contacts = response.data.data;
                    UX.removeSpin().addTimes().removeClicked();
                });
            },

            formCompleteNewContact (data, response)
            {
                this.$store.dispatch('showAlertSuccess',
                {
                    title: "Success",
                    msg: response.data.message
                });
                if(!this.client.jdoc){
                    this.client.jdoc = {};
                }
                this.client.jdoc.contacts = response.data.data;
                this.newContact = this.defaultNewContact();
            },

            handleImageUpload(imgInfo, imgData)
            {
                let result = imageUpload.saveClientLogo(imgInfo, imgData, this.client).then((result) => {
                  this.$store.dispatch('showAlertSuccess',
                      {
                          title: "Success",
                          msg: "Logo updated successfully."
                      });
                });
            },

            formSubmitting()
            {
                this.logoTempSave = this.client.logo;
                delete this.client.logo;
            },

            mainFormComplete(user, response){
              if(response.status == 200) {
                  this.$store.dispatch('showAlertSuccess', {title: "Success", msg: response.data.message})
              }
            },

            toggleEditMode ()
            {
                this.edit_mode = !this.edit_mode;
                if (typeof this.logoTempSave !== 'undefined' && typeof this.client.logo === 'undefined') {
                    this.client.logo = this.logoTempSave;
                    delete this.logoTempSave;
                }
            },
        },
        components: {
            ApiForm,
            SecureImg,
            FormInput,
            Formatter,
            FormHidden,
            ClientForm
        }
    }
</script>
