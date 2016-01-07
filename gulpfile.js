var gulp = require('./gulp');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var wiredep = require('wiredep').stream;
var sass = require('gulp-sass');

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['watch', 'bower', 'sass']);
