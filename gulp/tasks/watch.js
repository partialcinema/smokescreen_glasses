var gulp = require('gulp');

// Watch .coffee, .scss, and index.html files for change
var watchTask = function () {
    gulp.watch('../../src/*.coffee', ['coffee']);
    gulp.watch('../../src/*.scss', ['sass']);
    gulp.watch('../../src/index.html', ['bower']);
};
gulp.task('watch', ['coffee', 'sass', 'bower'], watchTask);

module.exports = 'watch';
