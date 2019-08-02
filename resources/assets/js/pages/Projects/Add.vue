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
            display: inline-block;
        }
    }
</style>
<style type="text/css">
  .asterisk{
    line-height: normal;
    position: absolute;
    z-index: 1;
    left: 22px;
    top: 5px;
  }
      
</style>
<template>
  <div>
    <api-form id="project-add-form"
        v-on:form-complete="formComplete"
        v-model="project" method="POST" action="/webapp/projects"
        v-permission="'ProjectsAlter'">
    <div class="center-children">
      <h3>Add Project</h3>
    </div>

    <div style="margin-bottom: 50px;">
        <h4>Project Information</h4>

        <div class="row">
            <div class="col-sm-3">
                <secure-img :edit_mode="edit_mode" :src="project.logo" className="img-rounded img-responsive" title="click to change logo" @image-uploaded="handleImageUpload"></secure-img>
            </div>
            <input type="hidden" name="image" v-model="project.image" />


            <div class="col-sm-9">
                  <div class="row">
                      <div class="col-sm-12">
                        <span class="asterisk" style="color:red;">*</span>
                        <form-input :edit_mode="edit_mode" v-model="project.name" placeholder="Project title"></form-input>
                      </div>
                  </div>

                  <div class="row">
                      <div class="col-sm-12">
                        <span class="asterisk" style="color:red;">*</span>
                        <form-input :edit_mode="edit_mode" v-model="project.description" placeholder="Project description"></form-input>
                      </div>
                  </div>

                  <div class="row">
                      <div class="col-sm-6">
                          <label>
                              Start Date<span style="color:red;">*</span>
                          </label>
                            <inverse-date-picker v-on:input="startDateChanged" v-model="project.startDate"
                                :option="option" placeholder="Choose start date" :format="'YYYY-MM-DD'">
                            </inverse-date-picker>

                      </div>
                      <div class="col-sm-6">
                          <label>
                              End Date<span style="color:red;">*</span>
                          </label>
                            <inverse-date-picker v-on:input="endDateChanged" v-model="project.endDate"
                                :option="option" placeholder="Choose end date" :format="'YYYY-MM-DD'">
                            </inverse-date-picker>
                      </div>
                  </div>
            </div>
          </div>
    </div>


    <div style="margin-bottom: 50px;">
        <h4>Project Location</h4>
        <div>
          <div class="row">
              <div class="col-sm-12">
                <span class="asterisk" style="color:red;">*</span>
                  <form-input :edit_mode="edit_mode" v-model="project.address" placeholder="Address"></form-input>
              </div>
          </div>

          <div class="row">
              <div class="col-sm-9">
                <span class="asterisk" style="color:red;">*</span>
                <form-input :edit_mode="edit_mode" v-model="project.city" placeholder="City"></form-input>
              </div>
              <div class="col-sm-1">
                <span class="asterisk" style="color:red;">*</span>
                <form-input :edit_mode="edit_mode" v-model="project.state" placeholder="State"></form-input>
              </div>
              <div class="col-sm-2">
                <span class="asterisk" style="color:red;">*</span>
                <form-input :edit_mode="edit_mode" v-model="project.zip" placeholder="Zip"></form-input>
              </div>
          </div>

          <div class="row">
              <div class="col-sm-6">
                <form-input :edit_mode="edit_mode" v-model="project.county" placeholder="county"></form-input>
              </div>
              <div class="col-sm-6">
                <form-input :edit_mode="edit_mode" v-model="project.country" placeholder="country"></form-input>
              </div>
          </div>
        </div>
      </div>

    <div style="margin-bottom: 50px;">
        <h4>Project Perimeter</h4>

          <div class="row">
              <div class="col-sm-6">
                Please set the project perimeter. Add points by clicking on the line then
                dragging the point where you want it. Remove points by right-clicking a point.
              </div>
              <div class="col-sm-6">
                  <div class="row">
                      <div class="col-sm-10 input-like">
                        Radius in meters: (if &lt;= 0, polyfence will be used instead)
                      </div>
                      <div class="col-sm-2">
                        <form-input :edit_mode="edit_mode" v-model="project.radius" placeholder="enter a radius, or 0 to use the
                            polyfence"></form-input>
                      </div>
                  </div>
              </div>
          </div>

          <div class="row">
              <div class="col-sm-6">
                  You may also alter the pin coordinates by entering them here. Note that the pin will not move until the
                  page is saved and reloaded.
              </div>
              <div class="col-sm-6">
                  <div class="row">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-6">
                                Lat:
                            </div>
                            <div class="col-sm-6">
                                <form-input :edit_mode="edit_mode" v-model="project.latitude" @input="coordsChanged"
                                    placeholder="Latitude">
                                </form-input>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-6">
                                Lng:
                            </div>
                            <div class="col-sm-6">
                                <form-input :edit_mode="edit_mode" v-model="project.longitude" @input="coordsChanged"
                                    placeholder="Longitude">
                                </form-input>
                            </div>
                        </div>
                    </div>
                  </div>
              </div>
          </div>

        <fence-map
            @shape-changed="shapeChanged"
            @marker-changed="markerChanged"
            :point="getPoint"
            :show-fence="showFence"
            :map-zoom="mapZoom"
            :map-center="mapCenter"
            :fence="getFence">
        </fence-map>

      <div class="row" style="margin-top: 15px;">
          <div class="col-sm-4">
              <input type="hidden" v-model="client_uniq_id" />
              <input type="submit" value="Add" />
          </div>
      </div>
    </div>
    </api-form>
  </div>
</template>
<script>
    import ApiForm from '../../components/ApiForm.vue'
    import InverseDatePicker from '../../components/DatePicker.vue'
    import FormInput from '../../components/ReactiveFormInput.vue'
    import FormHidden from '../../components/FormHidden.vue'
    //import User from '../../api/user';
    import FenceMap from '../../components/FenceMap.vue'
    import SecureImg from '../../components/SecureImg.vue';

    export default {
        name: 'project-edit',
        data () {
            return {
                Perm: Perm,
                edit_mode: true,
                mapCenter: {
                    "lat": 40,
                    "lng": -80
                },
                mapZoom: 12,
                project: {
                    client_uniq_id: User.profile().client.uniq_id,
                    name: '',
                    image : '',
                    description: '',
                    startDate: '',
                    endDate: '',
                    address: '',
                    city: '',
                    state: '',
                    zip: '',
                    county: '',
                    country: '',
                    status: 'active',
                    polyfence: '((40.019509285964965,-79.97926114777266),(40.01877454435347,-80.02068623615816),(39.991526143858344,-80.01939944146744),(39.99188336855925,-79.99366151757704),(39.99197462524793,-79.97890916833921),(40.019509285964965,-79.97926114777266))',
                    pointfence: '(40,-80)',
                    latitude: '40',
                    longitude: '-80',
                    radius: 0
                },
            }
        },
        created () {
        },
        computed: {
            showFence: function ()
            {
                return this.project.radius <= 0 && !this.loading;
            },

            getPoint: function()
            {
                return this.project.pointfence.substr(1, this.project.pointfence.length-2);
            },

            getFence: function ()
            {
                if (this.getPoint !== null) {
                    let latlon = this.getPoint.split(',');
                    this.mapCenter = {lat: parseFloat(latlon[0]), lng: parseFloat(latlon[1])}
                }

                let polyFence = this.project.polyfence.replace(new RegExp(/\),\(/, 'g'), '|')
                polyFence = polyFence.replace(new RegExp(/\)+/, 'g'), '');
                polyFence = polyFence.replace(new RegExp(/\(+/, 'g'), '');
                polyFence = polyFence.split('|');

                let ret = []

                for (let point in polyFence) {
                    let pointParts = polyFence[point].split(',');
                    ret.push({lat: parseFloat(pointParts[0]), lng: parseFloat(pointParts[1])});
                }

                return ret;
            }
        },
        components: {
            ApiForm,
            FormInput,
            InverseDatePicker,
            FormHidden,
            FenceMap,
            SecureImg
        },
        methods: {
            formComplete: function(project, response) {
                if (response.status == 200) {

                    this.edit_mode = false;

                    this.$store.dispatch('showAlertSuccess',
                    {
                        title: "Success",
                        msg: response.data.message
                    });

                    this.$router.push({name: 'project-summary', params: {project_id: response.data.data.uniq_id}});
                } else {
                    this.$store.dispatch('showAlertFail',
                    {
                        title: "There was a problem",
                        msg: response.data.message
                    });
                }
            },
            startDateChanged: function (data) {
                this.project.startDate = data;
            },
            endDateChanged: function (data) {
                this.project.endDate = data;
            },
            shapeChanged: function (newPath)
            {
                let ret = [];
                for (let i=0; i<newPath.getLength(); i++) {
                    let myPath = newPath.getAt(i);
                    let myPos  = myPath.lat() + ',' + myPath.lng();
                    ret.push('(' + myPos + ')');
                }

                this.project.polyfence = '(' + ret.join(',') + ')'
            },
            coordsChanged: function ()
            {
              console.log("this.project",this.project);
                this.project.pointfence = '(' + this.project.latitude + ',' + this.project.longitude + ')';
                this.mapCenter = {lat: parseFloat(this.project.latitude), lng: parseFloat(this.project.longitude)}
            },
            markerChanged: function (newPosition) {
                this.project.pointfence = '(' + newPosition.lat() + ',' + newPosition.lng() + ')'
                this.project.latitude = newPosition.lat()
                this.project.longitude = newPosition.lng()
            },
            handleImageUpload(imgInfo, imgData) {
              let imgSplit = imgData.split(',', 2);
              this.project.image = imgSplit[1];
            },
        }
    }
</script>
