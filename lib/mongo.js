(function() {
  var config, connectString, mongo;
  mongo = require('mongoskin');
  config = require('./config');
  config = config.config;
  connectString = exports.connectString = "http://" + config.host + ":" + config.port + "/";
  exports.db = mongo.db("" + exports.connectString + config.db);
  exports.setDB = function(name) {
    var db;
    return db = mongo.db("" + connectString + config.db);
  };
  exports.getDB = function(name) {
    var dbget;
    console.log("" + connectString + name);
    dbget = mongo.db("" + connectString + name);
    return dbget;
  };
  exports.createCollection = function(name, callback) {
    return exports.db.createCollection(name, callback);
  };
  exports.dropCollection = function(name, callback) {
    return exports.db.dropCollection(name, callback);
  };
}).call(this);
