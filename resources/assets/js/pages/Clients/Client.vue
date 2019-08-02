<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';
        // h4 {
        //     padding-bottom: 5px;
        //     border-bottom: 2px solid #ccc;
        // }

        h3 {
            margin: auto;
            margin-top: 25px;
            display: inline-block;
        }
        .collapsible-content {
            margin-left: 0;
            margin-right: 0;
        }
</style>
<template>
    <div>
        <div class='major-section-header-row'>
            <h2 v-if="edit_mode">Edit Company Profile</h2>
            <h2 v-if="!edit_mode">Company Profile</h2>
        </div>

        <loader :loading="loading"></loader>

        <div v-show="!loading">
            <api-form id="client-update-form"
                method="PUT" action="/webapp/clients"
                v-model="client"
                @form-submitting="formSubmitting"
                v-on:form-complete="toggleEditMode">
                <h4>Company Information</h4>

                <div class="row collapsible-content">
                    <div class="col-sm-4" v-if="client.logo">
                        <secure-img :edit_mode="edit_mode" :src="client.logo" className="img-rounded img-responsive" title="click to change logo" @image-uploaded="handleImageUpload"></secure-img>
                    </div>
                    <div class="col-sm-8">
                        <form-hidden name="uniq_id" :data="client.uniq_id">
                            Company ID
                        </form-hidden>
                        <client-form v-if="client.uniq_id" :client="client" :edit_mode="edit_mode"></client-form>
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
    let imageUpload = require ('../../helpers/imageupload.js').default;
    let formatHelper = require ('../../helpers/format.js').default;
    import ClientForm from './ClientForm.vue'
    import FormInput from '../../components/ReactiveFormInput.vue'
    import Formatter from '../../components/Formatter.vue'
    import FormHidden from '../../components/FormHidden.vue';
    import ApiForm from '../../components/ApiForm.vue'
    import SecureImg from '../../components/SecureImg.vue';
    import UX from '../../helpers/UX';

    export default {
        name: 'client-main',
        data () {
            return {
                loading: true,
                uniq_id: this.$route.params.uniq_id,
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
                                                'logo',
                                                'jdoc'
                                            ]);
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

            handleImageUpload(imgInfo, imgData)
            {
                let result = imageUpload.saveClientLogo(imgInfo, imgData, this.client);
            },

            formSubmitting()
            {
                this.logoTempSave = this.client.logo;
                delete this.client.logo;
            },

            toggleEditMode ()
            {
                this.edit_mode = !this.edit_mode;
                if (typeof this.logoTempSave !== 'undefined' && typeof this.client.logo === 'undefined') {
                    this.client.logo = this.logoTempSave;
                    delete this.logoTempSave;
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
                    UX.removeSpin().addTimes();
                });
            },

            formCompleteNewContact (data, response)
            {
                this.client.jdoc.contacts = response.data.data;
                this.newContact = this.defaultNewContact();
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
