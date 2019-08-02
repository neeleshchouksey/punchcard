<template>
    <div class="loader" v-if="loading">
        <div :style="boundStyle">
          <i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i>
        </div>
        <div>
            {{ loading_msg }}
        </div>
    </div>
</template>
<script>
export default {
    data: function() {
        return {
            boundStyle: {
                fontSize: this.size + 'px'
            },
        }
    },
    props: {
        loading: {
            type: Boolean,
            default: true
        },
        size: {
            type: String,
            default: '17',
        },
        loading_msg: {
            type: String,
            default: "Loading..."
        }
    },
    computed: {
    }
}
</script>
<style scoped>
    div { text-align: center; }
    .loader {
      min-height: 20px;
      display: flex;
      align-items: center;
      text-align: center;
      justify-content: center;
    }
</style>
