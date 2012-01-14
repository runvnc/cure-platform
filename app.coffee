security = require './lib/security/security'
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

browserify = require 'browserify'
#bundle = browserify
#  mount: "#{__dirname}/views/js/test.js"
#  require: 'util', 'fs', 'node-uuid', 'coffee-script', 'mongolian', 'drykup'
bundle = browserify __dirname + '/views/test.js'
app.use bundle

security.addpermission 'guests', 'todo', 'all'
app.get '/todo', (req, res) ->
  res.render 'todo.html'

app.get '/about', (req, res) ->
  res.render 'about.html'



app.listen 3000

nowjs = require 'now'
everyone = nowjs.initialize app
