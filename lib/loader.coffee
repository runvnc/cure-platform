fs = require 'fs'
plugins = require './plugins'
generators = require './generators'
util = require 'util'


firstprop = (obj) ->
  props = (prop for prop, val of obj)
  props[0]

firstval = (obj) ->
  vals = (val for prop, val of obj)
  vals[0]

loadall = (plugin) ->
  path = "#{__dirname}/#{plugin}"
  files = fs.readdirSync path
  for f in files when f isnt 'main.coffee'
    r = require "#{path}/#{f}"

exports.load = ->
  loadall(firstprop plugin) for plugin in plugins when firstval(plugin) is on

  generators.makeFunctions()
 
  loadall 'main'

  main = require './main/main'

  generators.generateAll('todo', main.run)
 
  true
