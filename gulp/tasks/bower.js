// Include bower components into html
module.exports = function () {
  gulp.src('./src/index.html')
    .pipe(wiredep())
    .pipe(gulp.dest('./public'));
};
