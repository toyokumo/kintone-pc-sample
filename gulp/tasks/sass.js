var sass = require('gulp-sass');
var gulp = require('gulp');
var rename = require('gulp-rename');
var minifycss = require('gulp-minify-css');
var handleErrors = require('../util/handleErrors');
var config = require('../cssConfig');

var apps = config.modules;

var createTask = function (src, dest) {
    return function () {
        return gulp.src(src)
            .on('error', handleErrors)
            .pipe(sass())
            .pipe(rename(dest + '.css'))
            .pipe(gulp.dest(config.destDir))
            .pipe(minifycss())
            .pipe(rename({suffix: '.min'}))
            .pipe(gulp.dest(config.destDir));
    };
};

// Generate sub tasks
apps.forEach(function (m) {
    gulp.task("sass:" + m,
        createTask([config.srcDir + m + "/" + config.entryPointFile],
            m));
});

// Generate main task
var tasks = apps.map(function (app) {
    return "sass:" + app;
});
gulp.task('sass', tasks);
