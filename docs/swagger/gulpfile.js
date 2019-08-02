var gulp = require('gulp');
var swagger = require('gulp-swagger');

gulp.task('default', function() {
  gulp.src('./punchcardv10/main.yaml')
    .pipe(swagger('punchcardv10.json'))
    .pipe(gulp.dest('./'));
});

//gulp.task('default', ['schema']);
gulp.watch('./punchcardv10#<{(||)}>#*.yaml', ['default']);
