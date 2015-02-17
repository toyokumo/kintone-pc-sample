var gulp = require('gulp');

//gulp.task('watch', ['setWatch', 'browserSync'], function() {
//    gulp.watch('src/*/styles/*.scss', ['sass']);
//    // Note: The browserify task handles js recompiling with watchify
//});
gulp.task('watch', ['setWatch', 'build'], function() {
  gulp.watch('src/*/styles/*.scss', ['sass']);
  // Note: The browserify task handles js recompiling with watchify
});
