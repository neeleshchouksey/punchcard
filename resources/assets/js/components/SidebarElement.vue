<style lang="sass" scoped>
    @import '../../sass/_variables.scss';
    li {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 80px;
        width: calc(100% - 10px);
        position: relative;
        transition: all 0.15s cubic-bezier(.25,.8,.25,1);
        margin: 5px;
        padding: 0;
        border-bottom: 1px solid lighten($theme-slate, 10%);
        * {
            color: $theme-white !important;
        }
    }

    .nav-sidebar li:hover {
        background-color: $theme-white;
        * {
            color: $theme-slate !important;
        }
    }

    .nav-sidebar li a, .nav li a {
        display: initial;
        position: initial;
        padding: initial;
    }

    div {
        text-align: center;
    }

    li div img {
        width: 80%;
        margin: auto;
    }
</style>
<template>
<router-link :to="pathWay">
    <li class="col-sm-12" >
        <div>
            <i :class="icon" aria-hidden="true"></i>
        </div>
        <div class='nav-title'>{{ title }}</div>
    </li>
</router-link>
</template>

<script>
    export default {
        data () {
            return {

            }
        },
        computed: {

            imageSrc: function ()
            {
                return DevConfig.url + this.image
            },

            pathWay: function ()
            {
                return this.path
            }

        },
        props: ['path', 'title', 'image', 'icon'],
        ready() {
        }
    }
</script>
