(function() {
  var testfunc, util;
  util = require('util');
  testfunc = function(x) {
    console.log('callee is ' + arguments.callee);
    console.log(x);
    return console.log(util.inspect(this));
  };
  console.log(util.inspect(testfunc()));
}).call(this);
