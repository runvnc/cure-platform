util = require 'util'

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

app.use require('browserify')({mount: "#{__dirname}/loader.coffee", require: 'util', 'fs', 'node-uuid', 'coffee-script', 'mongolian', 'drykup'})
