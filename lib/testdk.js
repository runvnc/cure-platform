(function() {
  var dk;
  dk = require('drykup')();
  dk.head(function() {
    return dk.title('Hello World');
  });
  dk.body(function() {});
  console.log(dk.htmlOut);
}).call(this);
