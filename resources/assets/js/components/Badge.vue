<style lang="sass" scoped>
    @import '../../sass/_variables.scss';

    @media print {
      img {
      -webkit-print-color-adjust: exact;
  }
}



    div.top {
        margin: 10px;
        padding: 20px;
        min-height: 200px;
    }
    h2 {
        text-align: center;
        margin: 20px 0;
    }
    .card {
        padding: 15px;
        flex-direction: row;
        align-items: center;
        h3 {
            margin: 5px 0;
        }
          .user-image{
            width: 130px;
          }

    }
</style>
<template>
    <div  :id="badge.badge_id"  style="position:relative;width:302px;margin: 10px;padding: 20px;min-height: 200px;padding: 15px;flex-direction: row;align-items: center;box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 1px 5px 0 rgba(0, 0, 0, 0.12), 0 3px 1px -2px rgba(0, 0, 0, 0.2);transition: all 0.1s cubic-bezier(0.25, 0.8, 0.25, 1); color: #111;background-color: #ebebeb;">
            <i class="fa fa-print" style="position: absolute;right: 15px;font-size: 20px;" aria-hidden="true" @click="printData(badge.badge_id)"></i>
            <div style="display: inline-flex;width: 100%;margin-bottom: 15px;margin-top: 15px;">
                <div style="width: 50% !important;">
                  <div style="color: #424a5d;font-size: 16px;">Project Name</div>
                  <div style="color: #424a5d;font-size: 16px;">{{ badge.project_name }}</div>
                </div>
                <div style="width: 50% !important;">
                  <div style="color: #424a5d;font-size: 16px;">Project Address</div>
                    <div style="color: #424a5d;font-size: 16px;">{{ project.address }}</div>
                </div>
            </div>
            <div style="display: inline-flex;width: 100%;margin-bottom: 15px;">
              <div style="width: 50% !important;">
                <div style="color: #424a5d;font-size: 16px;">Company</div>
                  <div style="color: #424a5d;font-size: 16px;">{{ badge.client_name }}</div>
              </div>
              <div style="width: 50% !important;">
                <div style="color: #424a5d;font-size: 16px;">Name</div>
                <div style="color: #424a5d;font-size: 16px;">{{ badge.name }}</div>
              </div>
            </div>
            <div style="display: inline-flex;width: 100%;margin-bottom: 15px;">
              <div style="width: 50% !important;">
                <div style="color: #424a5d;font-size: 16px;">Badge Id</div>
                  <div style="color: #424a5d;font-size: 20px;">{{ badge.badge_id }}</div>
              </div>
            </div>
            <div>

              <image64 v-if="badge.avatar_location" :src="badge.avatar_location"
                  imgStyle="height:160px !important" className="image-height user-image img-rounded img-responsive">
              </image64>

              <image64 v-if="badge.qr_location" :src="badge.qr_location"
                  imgStyle="height:160px !important" className="image-height img-rounded img-responsive">
              </image64>
            </div>
        </div>
    </div>
</template>
<script>
    import SecureImg from '../components/SecureImg.vue';
    import Image64 from '../components/Image64.vue';

    export default {
        name: 'badge',
        data () {
            return {
                loading: true,
            }
        },
        created () {
        },
        props: {
            project: {
                type: Object,
                default: function () {
                    return {
                        logo: null,
                    }
                }
            },
            badge: {
                type: Object,
                default: function () {
                    return {
                        name: null,
                        client_name: null,
                        project_name: null,
                        badge_id: null,
                        avatar_location: null,
                        qr_location: null
                    }
                }
            },
        },
        computed: {
        },
        components: {
            SecureImg,
            Image64
        },
        methods: {
           printData: function(id) {
             var divToPrint=document.getElementById(id);
             var newWin= window.open("");
             newWin.document.write(divToPrint.outerHTML);
             newWin.print();
             newWin.close();
          }

        }
    }
</script>
