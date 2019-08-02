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

    h3 {
        text-decoration: none;
        border: none;
    }
</style>
<template>
    <div>
        <div v-show="!loading">
            <div class="center-image">
                <img :class="imgClass" :src="localSrc" ref="secureimg" style="margin: auto;"/>
            </div>

            <div v-show="edit_mode" class="center-image">
                <input id="files" placeholder="Select an image to upload" type="file" @change="onFileChange" class="hidden">
                <label for="files" class="button">Select replacement image</label>
            </div>
        </div>

        <loader :loading="loading" loading_msg="Loading ..."></loader>
    </div>
</template>
<script>
    let imageUpload = require ('../helpers/imageupload.js').default;

    export default {
        name: 'secure-img',
        data () {
            return {
                loading: false,
            }
        },
        mounted () {
            //this.updateImage()
        },
        props: {
            edit_mode: {
                type: Boolean,
                default: false
            },
            className: {
                type: String,
                default: 'img-responsive'
            },
            refresh: {
                type: Boolean,
                default: false
            },
            src: {
                type: String,
                default: null
            }
        },
        created () {
        },
        computed: {
            imgClass: function () {
                return this.className;
            },
            localSrc: function () {
                return this.getSrc()
            }
        },
        components: {
        },
        methods: {
            getSrc: function ()
            {
                if (this.src === null) {
                    return
                }

                if (this.src.search(/^http/) >= 0)  {
                    return imageUpload.bust(this.src)
                } else {
                    let url = DevConfig.url + this.src;
                    return imageUpload.bust(url.replace('//', '/'));
                }
            },
            updateImage: function ()
            {
                if (this.src === null) {
                    return;
                }

                let image = null;

                if (this.refresh || image === null) {
                    this.loading = true;
                    let src = this.getSrc();

                    this.$http.get(src).then((response) => {
                        return response.blob();
                    }).then((image) => {
                        let reader = new FileReader();

                        reader.onload = (e) => {
                            if (typeof this.$refs.secureimg !== 'undefined') { // if they have moved on from the page, it won't be there anymore
                                this.$refs.secureimg.src = reader.result;
                                this.loading = false;
                            }
                        }

                        //
                        // This is the async call, with the 'onload'
                        // above as the callback
                        //
                        reader.readAsDataURL(image);
                    });
                } else {
                    this.loading = false;
                    this.$refs.secureimg.src = image;
                }
            },

            onFileChange(e)
            {
                var files = e.target.files || e.dataTransfer.files;
                if (!files.length) {
                    return;
                }

                this.createImage(files[0]);
            },

            createImage(file)
            {
                console.log(file);
                if (file.size > 500000) {
                    this.$store.dispatch('showAlertFail',
                    {
                        title: "Image too large",
                        msg: 'Please upload an image smaller that 500kb (.5 megabyte)'
                    });
                    return;
                }

                let image  = new Image();
                let reader = new FileReader();

                reader.onload = (e) => {
                    this.$refs.secureimg.src = e.target.result;
                    this.$emit('image-uploaded', file, e.target.result);
                };

                reader.readAsDataURL(file);
            },

            removeImage(e)
            {
                this.image = '';
            }
        }

    }
/*
                    this.$http.get(src, {
                       'headers': {
                           'Cache-Control': 'public'
                       }
*/
</script>
