<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    @import '../../sass/app.bs.css';
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
    <api-form id="project-update-form"
        v-on:form-submitting="formSubmitting"
        v-on:form-complete="formComplete"
        v-model="project" method="PUT" action="/webapp/projects"
        v-permission="'ProjectsAlter'">
    <div class="center-children">
      <h3>Edit Project</h3>
    </div>

    <div style="margin-bottom: 50px;">
        <h4>Project Information</h4>

        <div class="row">
            <div class="col-sm-3" v-if="logo">
                <secure-img :edit_mode="edit_mode"
                    :src="logo" className="img-rounded img-responsive"
                    title="click to change logo" @image-uploaded="handleImageUpload">
                </secure-img>
            </div>

            <div class="col-sm-9">
                  <div class="row">
                      <div class="col-sm-12">
                          Project ID: {{ project.uniq_id }}
                      </div>
                  </div>

                  <div class="row">
                      <div class="col-sm-12">
                        <span class="asterisk" style="color:red;">*</span>
                        <form-input name="name" :edit_mode="edit_mode" v-model="project.name" placeholder="Project title"></form-input>
                      </div>
                  </div>

                  <div class="row">
                      <div class="col-sm-12">
                        <span class="asterisk" style="color:red;">*</span>
                        <form-input name="description" :edit_mode="edit_mode" v-model="project.description" placeholder="Project description"></form-input>
                      </div>
                  </div>

                  <div class="row">
                      <div class="col-sm-6">
                          <label>
                              Start Date<span style="color:red;">*</span>
                          </label>
                            <inverse-date-picker v-if="project.startDate" v-model="project.startDate"
                                placeholder="Choose start date"></inverse-date-picker>

                      </div>
                      <div class="col-sm-6">
                          <label>
                              End Date<span style="color:red;">*</span>
                          </label>
                            <inverse-date-picker v-if="project.endDate" v-model="project.endDate" placeholder="Choose end date"></inverse-date-picker>
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
                  <form-input name="address" :edit_mode="edit_mode" v-model="project.address" placeholder="Address"></form-input>
              </div>
          </div>

          <div class="row">
              <div class="col-sm-9">
                <span class="asterisk" style="color:red;">*</span>
                <form-input name="city" :edit_mode="edit_mode" v-model="project.city" placeholder="City"></form-input>
              </div>
              <div class="col-sm-1">
                <span class="asterisk" style="color:red;">*</span>
                <form-input name="state" :edit_mode="edit_mode" v-model="project.state" placeholder="State"></form-input>
              </div>
              <div class="col-sm-2">
                <span class="asterisk" style="color:red;">*</span>
                <form-input name="zip" :edit_mode="edit_mode" v-model="project.zip" placeholder="Zip"></form-input>
              </div>
          </div>

          <div class="row">
              <div class="col-sm-6">
                <form-input name="county" :edit_mode="edit_mode" v-model="project.county" placeholder="county"></form-input>
              </div>
              <div class="col-sm-6">
                <form-input name="country" :edit_mode="edit_mode" v-model="project.country" placeholder="country"></form-input>
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
            v-if="project.uniq_id"
            :point="getPoint"
            :show-fence="showFence"
            :map-zoom="mapZoom"
            :map-center="mapCenter"
            :fence="getFence">
        </fence-map>

      <div class="row" style="margin-top: 15px;">
          <div class="col-sm-4">
            <form-dropdown :edit_mode="edit_mode"
                v-if="project.status" v-model="project.status" :options="statusOptions">
               Status
            </form-dropdown>
          </div>
          <div class="col-sm-4 input-like">
              <input type="submit" class="btn" value="Save">
          </div>
      </div>
    </div>
    </api-form>

    <api-form id="project-delete-form" style="margin-top: 200px"
        v-on:form-complete="formCompleteDelete"
        v-model="project" method="DEL" action="/webapp/projects"
        v-permission="'ProjectsAlter'">
        <div class="row">
            <button type="submit" class="btn btn-danger" @click="confirmDelete">
                Delete
            </button>
        </div>
    </api-form>
</div>
</template>
<script>
    let imageUpload = require ('../helpers/imageupload.js').default;
    import ApiForm from '../components/ApiForm.vue'
    import InverseDatePicker from '../components/DatePicker.vue'
    import FormInput from '../components/ReactiveFormInput.vue'
    import FormHidden from '../components/FormHidden.vue'
    import FormDropdown from '../components/FormSelect.vue';
    //import User from '../api/user';
    import FenceMap from '../components/FenceMap.vue'
    import SecureImg from '../components/SecureImg.vue';

    export default {
        name: 'project-edit',
        data () {
            return {
                Perm: Perm,
                edit_mode: true,
                loading: true,
                mapCenter: {
                    "lat": 40,
                    "lng": -80
                },
                mapZoom: 12,
                logo: null,
                statusOptions: [
                    {text: 'Active', value: 'active' },
                    {text: 'Inactive', value: 'inactive' }
                ],
                project: {
                    uniq_id: null,
                    name: null,
                    description: null,
                    startDate: null,
                    endDate: null,
                    address: null,
                    city: null,
                    state: null,
                    zip: null,
                    county: null,
                    country: null,
                    status: null,
                    polyfence: null,
                    pointfence: null,
                    radius: 0,
                },
            }
        },
        created () {
            this.routes = Api.getRoutes('webapp-projects');

            this.routes.projects.get().then((projects) => {
                this.projects = projects;
            });

            //
            // This one
            //
            this.routes.projects.get(this.$route.params.project_id).then((project) => {
                this.logo = project.logo;
                this.project = _.pick(project, ['name',
                                                    'address',
                                                    'city',
                                                    'state',
                                                    'zip',
                                                    'county',
                                                    'country',
                                                    'uniq_id',
                                                    'description',
                                                    'startDate',
                                                    'endDate',
                                                    'latitude',
                                                    'longitude',
                                                    'polyfence',
                                                    'pointfence',
                                                    'radius',
                                                    'status',
                                                ]
                )
                this.loading = false;
            });
        },
        computed: {
            showFence: function()
            {
                return this.project.radius <= 0 && !this.loading;
            },

            getPoint: function()
            {
                if (typeof this.project.pointfence === 'undefined') {
                    return null;
                }

                if (this.project.pointfence === null) {
                    return null;
                }

                let sub = this.project.pointfence.substr(1, this.project.pointfence.length-2);

                return sub;
            },

            getFence: function ()
            {
                if (this.getPoint !== null) {
                    let latlon = this.getPoint.split(',');
                    this.mapCenter = {lat: parseFloat(latlon[0]), lng: parseFloat(latlon[1])}
                }

                if (typeof this.project.polyfence === 'undefined') {
                    return this.makeBox(this.mapCenter);
                }

                if (this.project.polyfence === null) {
                    return this.makeBox(this.mapCenter);
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
            FormDropdown,
            FormHidden,
            FenceMap,
            SecureImg
        },
        methods: {
            confirmDelete(e) {
                if (!confirm ('Really Delete this project?')) {
                    //document.getElementById('project-delete-form').submit().preventDefault();
                    e.preventDefault();
                    e.stopPropagation();
                }
            },

            makeBox: function(start)
            {
                let lat  = start.lat
                let lng  = start.lng
                let spread = .05

                let points = [start]
                points.push({lng: (lng + spread), lat: lat})
                points.push({lng: (lng + spread), lat: (lat - spread)})
                points.push({lng: lng, lat: (lat - spread)})
                points.push(start)

                return points
            },
            formSubmitting: function (project) {
            },
            formCompleteDelete: function (project, response) {
                this.$router.push({name: 'projects'});
                this.$store.dispatch('showAlertSuccess',
                    {
                        title: "Success",
                        msg: response.data.message
                    });
            },

            formComplete: function(project, response) {
                //Api.update(project.uniq_id, project);
                this.$store.dispatch('showAlertSuccess',
                    {
                        title: "Success",
                        msg: response.data.message
                    });
                    window.history.back();
            },

            startDateChanged: function (data) {
                this.project.startDate = data;
            },

            coordsChanged: function ()
            {
                this.project.pointfence = '(' + this.project.latitude + ',' + this.project.longitude + ')';
                this.mapCenter = {lat: parseFloat(this.project.latitude), lng: parseFloat(this.project.longitude)}
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
            markerChanged: function (newPosition) {
                this.project.pointfence = '(' + newPosition.lat() + ',' + newPosition.lng() + ')';
                this.project.latitude = newPosition.lat()
                this.project.longitude = newPosition.lng()
            },
            handleImageUpload(imgInfo, imgData) {
                let result = imageUpload.saveProjectLogo(imgInfo, imgData, this.project).then((result) => {
                  this.$store.dispatch('showAlertSuccess',
                      {
                          title: "Success",
                          msg: "Logo updated successfully."
                      });
                });
            },
        }
    }
</script>
