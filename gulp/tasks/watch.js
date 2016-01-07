// Watch .coffee, .sccs, and index.html files for change
module.exports = {
  dependencies: ['coffee', 'sass', 'bower'],
  funk: function() {
    gulp.watch('./src/*.coffee', ['coffee']);
    gulp.watch('./src/*.scss', ['sass']);
    gulp.watch('./src/index.html', ['bower']);
  }
}
