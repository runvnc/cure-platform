#implements shared type dbinterface
#for mongodb

mongo = require 'mongoskin'

config = require './config'

config = config.config

connectString = exports.connectString = "http://#{config.host}:#{config.port}/"

exports.db = mongo.db "#{exports.connectString}#{config.db}"

exports.setDB = (name) ->
  db = mongo.db "#{connectString}#{config.db}"


#exports.dbExists = (name, callback) ->
#  console.log 'Inside of dbExists'
#  dbtst = mongo.db "#{connectString}#{name}"
#  console.log 'Tried to connect'
#  callback(true)

exports.getDB = (name) ->
  console.log "#{connectString}#{name}"
  dbget = mongo.db "#{connectString}#{name}"
  dbget

#exports.dropDB = (name, callback) =>
#  dbdrop = mongo.db "#{connectString}#{name}"
#  dbdrop.dropDatabase name, (err, done) ->
#    callback err, done

#exports.createDB = (name, callback) =>
#  mongo.db name, (err, done) ->
#    callback err, done

exports.load = (collection, objectid) ->

#exports.find = (collection, criteria) ->


exports.save = (collection, object) ->
  exports.db.insert collection, object

exports.createCollection = (name, callback) ->
  exports.db.createCollection name, callback

exports.dropCollection = (name, callback) ->
  exports.db.dropCollection name, callback


