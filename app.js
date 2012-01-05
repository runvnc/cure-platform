(function() {
  var apage, app, express, util;
  util = require('util');
  express = require('express');
  app = module.exports = express.createServer();
  process.on('uncaughtException', function(err) {
    console.log(err.message);
    return console.log(err.stack);
  });
  app.set('view engine', 'ejs');
  app.set("view options", {
    layout: false
  });
  app.register('.html', require('ejs'));
  app.register('.coffee', require('coffeekup').adapters.express);
  apage = function() {
    return htmlpage('todo.html', 'true)');
  };
  app.get('/todo.html', function(req, res) {
    return res.render('todo.html');
  });
  app.listen(3000);
}).call(this);
