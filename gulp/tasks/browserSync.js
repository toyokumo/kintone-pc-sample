var browserSync = require('browser-sync');
var gulp = require('gulp');
var config = require('../config');

gulp.task('browserSync', ['build'], function () {
    browserSync.init([config.destDir + '**'], {
        server: {
            baseDir: './web/', // ルートディレクトリ
            index: 'test.html'
        },
        notify: true
    });
});
