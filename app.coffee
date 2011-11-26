util = require 'util'

express = require 'express'

app = module.exports = express.createServer()

process.on 'uncaughtException', (err) ->
  console.log err.message
  console.log err.stack

app.set 'view engine', 'coffee'
app.set 'view engine', 'ejs'
#app.register '.coffee', require('coffeekup').adapters.express


app.get '/test', (req, res) ->
  res.render 'test', food: 'bar'
 

app.listen 3000
