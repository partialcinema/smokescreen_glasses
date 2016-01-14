var notifier = require('node-notifier');
var path = require('path');

module.exports = function(err) { 
  console.log(err);
  errorMessage = err.toString().replace(/.*smokescreen_glasses/, '');
  notifier.notify({
    title: 'Gulp build error',
    message: errorMessage,
    icon: path.join(__dirname, '../img', 'bmo-sad.png'),
  });
  this.emit('end'); 
};
