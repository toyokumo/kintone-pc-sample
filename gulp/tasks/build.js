var gulp = require('gulp'),
    gulpsync = require('gulp-sync')(gulp);

gulp.task('build', gulpsync.sync([['browserify', 'sass']]));
