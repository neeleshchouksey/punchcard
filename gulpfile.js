const elixir = require('laravel-elixir');

require('laravel-elixir-vue-2');

// figure out how to version only for production; going to pollute the
// repo with tons of these versions...
// https://laracasts.com/discuss/channels/general-discussion/can-elixir-version-be-run-only-on-production

// version images: https://www.neontsunami.com/posts/using-laravel-elixir-to-version-image-asset://www.neontsunami.com/posts/using-laravel-elixir-to-version-image-assets

elixir(mix => {
    mix.sass([
        'app.scss',
        'app.bs.css'
    ]).webpack('app.js')
      .version(['css/app.css', 'js/app.js'])
});

      //.browserSync({proxy: 'api.punchcardllc.com'});
