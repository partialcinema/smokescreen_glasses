var gulp = require('gulp');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');

// Transpile CoffeeScript
var coffeeTask = function() {
  gulp.src('../../src/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('../../public/'))
};
gulp.task('coffee', coffeeTask);

module.exports = 'coffee';
