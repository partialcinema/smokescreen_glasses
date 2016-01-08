var gulp = require('gulp');
var coffee = require('gulp-coffee');
//var gutil = require('gulp-util');
var source = require('vinyl-source-stream');
var browserify = require('browserify');

var scriptTask = function () {
  return browserify('./src/script.coffee', { extensions: ['.coffee'] })
    .transform('coffeeify')
    .bundle()
    .pipe(source('script.js'))
    .pipe(gulp.dest('./public'));
};
gulp.task('script', scriptTask);
// Transpile CoffeeScript
//var coffeeTask = function() {
  //gulp.src('./src/*.coffee')
    //.pipe(coffee({bare: true}).on('error', gutil.log))
    //.pipe(gulp.dest('./public/'))
//};
//gulp.task('coffee', coffeeTask);

module.exports = 'script';
