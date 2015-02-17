var browserify   = require('browserify');
var watchify     = require('watchify');
var gulp         = require('gulp');
var rename       = require('gulp-rename');
var uglify       = require('gulp-uglify');
var buffer       = require('vinyl-buffer');
var source       = require('vinyl-source-stream');
var sourcemaps   = require('gulp-sourcemaps');
var bundleLogger = require('../util/bundleLogger');
var handleErrors = require('../util/handleErrors');
var config       = require('../jsConfig');
var apps         = config.modules;

var createTask = function(entries, dest){
  return function() {
    var prm = {
      entries: entries,
      extensions: ['.coffee'],
      debug: true
    };

    var bundler = global.isWatching ? watchify(browserify(prm)) : browserify(prm);

    var bundle = function() {
      bundleLogger.start();

      return bundler
      .bundle()
      .on('error', handleErrors)
      .pipe(source(dest + ".js"))
      .pipe(buffer())
      .pipe(gulp.dest(config.destDir))
      .pipe(uglify())
      .pipe(rename({suffix: '.min'}))
      .pipe(gulp.dest(config.destDir))
      .on('end', bundleLogger.end);
    };

    if(global.isWatching) {
      // Rebundle with watchify on changes.
      bundler.on('update', bundle);
    }

    return bundle();
  };
};
// Generate sub tasks
apps.forEach(function (m) {
    gulp.task("browserify:" + m,
        createTask([config.srcDir + m + "/" + config.entryPointFile], m));
});

// Generate main task
var tasks = apps.map(function (app) {
    return "browserify:" + app;
});

gulp.task('browserify', tasks);
