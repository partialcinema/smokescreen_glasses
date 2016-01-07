var gulp = require('gulp');

function defineTask(name) {
  // require task
  var task = require('./tasks/' + name);

  // parse task
  var dependencies = null;
  var func = null;
  if(typeof task === "function") {
    dependencies = [];
    func = task;
  } else {
    dependencies = task.dependencies;
    func = task.func;
  }

  // define task
  gulp.task(name, dependencies, func);
}

module.exports = function(tasks) {
  tasks.forEach(defineTask);
  return gulp;
};
