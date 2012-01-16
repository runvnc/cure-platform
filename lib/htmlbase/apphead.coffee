util = require 'util'
dbx = require './lib/db/db.coffee'
db = dbx.db

express = require 'express'

app = module.exports = express.createServer()

process.on 'uncaughtException', (err) ->
  console.log err.message
  console.log err.stack

#app.set 'view engine', 'coffee'
app.set 'view engine', 'ejs'
app.set("view options", { layout: false })
app.register '.html', require('ejs')
app.register '.coffee', require('coffeekup').adapters.express
app.use '/', express.static(__dirname + '/views')

browserify = require 'browserify'
bundle = browserify
  entry: "#{__dirname}/views/test.coffee"
  require: 'util', 'fs', 'node-uuid', 'coffee-script', 'mongolian', 'drykup'
app.use bundle

