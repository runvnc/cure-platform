(function() {
  var app, express, util;
  util = require('util');
  express = require('express');
  app = module.exports = express.createServer();
  process.on('uncaughtException', function(err) {
    console.log(err.message);
    return console.log(err.stack);
  });
  app.set('view engine', 'coffee');
  app.set('view engine', 'ejs');
  app.get('/test', function(req, res) {
    return res.render('test', {
      food: 'bar'
    });
  });
  app.listen(3000);
}).call(this);
