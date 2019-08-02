<style lang="sass">
    .hidden {
        display: none;
    }
    .button:hover {
        font-weight: 700;
    }
    .button {
        cursor: pointer;
    }
    .center-image {
        text-align: center;
    }
      .image-height{
        height: 160px !important;
      }

    h3 {
        text-decoration: none;
        border: none;
    }
</style>
<template>
<div>
  <div v-show="!loading">
    <!-- show not if or $refs cannot be found -->
    <div class="center-image">
      <img :class="imgClass" :style="imageStyle" ref="image64" style="margin: auto;" />
    </div>
  </div>

  <loader :loading="loading" size="7" loading_msg=""></loader>
</div>
</template>
<script>
export default {
  name: 'image64',
  data() {
    return {
      loading: true,
    }
  },
  mounted() {
    if (this.src === null) {
      return;
    }

    this.loading = true;
    let src = this.getSrc();

    var xhr = new XMLHttpRequest();
    xhr.open("GET", src, true);
    xhr.setRequestHeader("X-CSRF-TOKEN", $('meta[name="csrf-token"]').attr('content'));
    xhr.setRequestHeader("Authorization", 'Bearer ' + User.authData().access_token);
    xhr.responseType = "blob";
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (((xhr.status === 200) || (xhr.status == 0)) && (xhr.response)) {
          console.log(src, xhr.response);
          this.setImage(xhr.response);
        }
      }
    }.bind(this);
    xhr.send(null);
    // this.updateImage()
  },
  props: {
    className: {
      type: String,
      default: 'img-responsive'
    },
    imgStyle: {
      type: String,
      default: null
    },
    src: {
      type: String,
      default: null
    }
  },
  created() {},
  computed: {
    imgClass: function() {
      return this.className;
    },

    imageStyle: function() {
      return this.imgStyle;
    },
    localSrc: function() {
      return this.getSrc()
    }
  },
  components: {},
  methods: {
    setImage: function(response) {
      let reader = new FileReader();
      reader.onload = (e) => {
        this.loading = false;
        if (typeof this.$refs.image64 !== 'undefined') { // if they have moved on from the page, it won't be there anymore
          this.$refs.image64.src = reader.result;
        }
      }
      reader.readAsDataURL(response);
    },
    cacheBusterKey: function() {
      return 'buster:' + btoa(this.src)
    },
    cacheBusterPut: function() {
      let key = this.cacheBusterKey()
      localStorage.setItem(key, Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 5))
    },
    cacheBusterGet: function() {
      let key = this.cacheBusterKey()
      return localStorage.getItem(key)
    },
    getSrc: function() {
      let buster = this.cacheBusterGet()

      if (this.src.search(/^http/) >= 0) {
        return this.src + '?cb=' + buster
      } else {
        let url = DevConfig.url + this.src + '?cb=' + buster
        return url.replace('//', '/');
      }
    },
    updateImage: function() {
      if (this.src === null) {
        return;
      }

      this.loading = true;
      let src = this.getSrc();

      this.$http.get(src, {
        'headers': {
          'Cache-Control': 'public'
        }
      }).then((response) => {
        return response.blob();
      }).then((image) => {
        let reader = new FileReader();

        reader.onload = (e) => {
          this.loading = false;
          if (typeof this.$refs.image64 !== 'undefined') { // if they have moved on from the page, it won't be there anymore
            this.$refs.image64.src = reader.result;
          }
        }

        //
        // This is the async call, with the 'onload'
        // above as the callback
        //
        reader.readAsDataURL(image);
      });
    },
  }

}
</script>
