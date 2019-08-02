<style lang="sass" scoped>
    @import '../../../sass/_variables.scss';

    .project {
        display: flex;
        align-items: center;
        align-content: space-between;
        flex-direction: row;
        justify-content: center;
        flex-wrap: wrap;
        > * {
            padding: 5px;
        }
        position: relative;
    }
    .project-row-1 {
        height: 75px;
        line-height: 1.4;
    }
    .project-row-2 {
        height: 120px;
        margin-top: 10px;
    }
    .project-logo {
        flex-basis: 130px;
        .img-rounded {
            height: 75px;
        }
    }

    .project-title {
        font-size: 3rem;
        font-weight: 600;
        flex-basis: calc(100% - 130px);
    }
    .project-description {
        width: calc(100% - 80px);
        display: flex;
        flex-direction: column;
        p:nth-child(1) {
            height: calc(100% - 25px);
            overflow: hidden;
        }
        p:nth-child(2) {
            height: 25px;
            margin: 0;
        }
    }
    .project-count {
        position: absolute;
        padding: 0;
        right: -17px;
        bottom: -17px;
        display: flex;
        justify-content: center;
        align-items: flex-end;

        .counter {
            padding: 12px 20px;
            border-radius: 6px 0 0 0;
            background-color: $theme-gold;
            color: $theme-black;
            font-weight: 800;
        }
    }
    .project-count-updated {
      position: absolute;
      padding: 0;
      right: 10px;
  bottom: 10px;
      display: flex;
      justify-content: center;
      align-items: flex-end;

        .counter {
          padding: 7px 16px;
          border-radius: 6px 0 0 0;
          background-color: #ffd777;
          color: #020C0C;
          font-weight: 800;
        }
    }

      .content-box{
        height: 137px;
        margin: 10px;


      }
        .content-section{
              height: 100%;
          color: $list-element-major-font-color;
          background-color: $list-element-major-bg;
          border: 1px solid transparent;
          border-color: $list-element-major-border;
          border-radius: $general-border-radius;
        }
        .content-section:hover {
            background-color: $list-element-major-hover-bg;
            border-color: $list-element-major-hover-border;
        }
          .details-text{
            font-size: 17px;
            margin: 6px 0px 0px 0px;
            white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
          }

</style>
<template>
<div>
  <div class="image col-sm-4">
    <secure-img :src="project.logo" className="size-75 img-rounded img-responsive" title=""></secure-img>
  </div>
  <div class="details col-sm-8">
    <div class="details-text"><span>Project Name: </span>{{ project.name }}</div>
    <div class="details-text"><span>Project Description: </span>{{ project.description }}</div>
    <div class="details-text"><span>Total Days Worked To {{getCurrentDate()}}: </span> <span v-if="project.oceanStats">{{ project.oceanStats.daysWorked }}</span></div>
    <div class="details-text"><span>Total Hours Worked To {{getCurrentDate()}}: </span>  <span v-if="project.oceanStats">{{ project.oceanStats.hoursWorked }}</span></div>
    <div class="details-text"><span>Total Active Users: </span>{{ project.oceanStats.employeesOnSite }}</div>
  </div>
  <div v-if='onSite' class='project-count-updated'><span class='counter'>{{project.oceanStats.employeesOnSite}}</span></div>
</div>

<!-- <div class='project'>
        <div class="project-logo project-row-1">
            <secure-img :src="project.logo" className="size-75 img-rounded img-responsive"></secure-img>
        </div>
        <div class='project-title project-row-1'><span>{{project.name}}</span></div>
        <div class='project-description project-row-2'>
            <p>{{ project.description }}</p>
            <p v-if="project.startDateFormatted">{{ project.startDateFormatted }} - {{ project.endDateFormatted }}</p>
        </div>
        <div v-if='onSite' class='project-count project-row-2'><span class='counter'>{{project.onSite}}</span></div>
    </div> -->
</template>
<script>
import SecureImg from '../../components/SecureImg.vue';

export default {
  name: 'project-list',
  data() {
    return {
      loading: true

    }
  },
  created() {},
  props: {
    onSite: {
      type: Boolean,
      default: false
    },
    project: {
      type: Object
    },
  },
  computed: {},
  components: {
    SecureImg
  },
  methods: {
    getCurrentDate : function(){
      return Moment(new Date()).format('DD-MM-YYYY');
    }
  },
  mounted() {
    $('.project-description > p:nth-child(1)').slimScroll({
      height: '100%'
    });
  }
}
</script>
