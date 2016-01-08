var gulp = require('gulp');
var wiredep = require('wiredep').stream;

// Include Bower components in html
var bowerTask = function () {
  gulp.src('../../src/index.html')
    .pipe(wiredep())
    .pipe(gulp.dest('../../public/'));
};
gulp.task('bower', bowerTask);

module.exports = 'bower';
