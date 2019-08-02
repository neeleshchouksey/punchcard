<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    div {

    }
</style>
<template>
    <div>
        <h2>Select an image</h2>
        <input placeholder="Select an image to upload" type="file" @change="onFileChange">
        <img :src="image" />
    </div>
</template>
<script>
    export default {
        name: 'image-upload',
        data () {
            return {
                image: null
            }
        },
        created () {
        },
        props: {
            renameMe: {
                type: String,
                default: null
            },
        },
        computed: {
        },
        components: {
        },
        methods: {
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
                    this.image = e.target.result;
                };

                reader.readAsDataURL(file);
            },

            removeImage(e)
            {
                this.image = '';
            }
        }
    }
</script>
