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
    console.log "Loading file #{plugin}/#{f}"
    r = require "#{path}/#{f}"

exports.load = ->
  loadall(firstprop plugin) for plugin in plugins when firstval(plugin) is on
  loadall 'main'
  generators.makeFunctions()
  main = require './main/main'
  if not main.run?
    console.log "Loader error: main must export run()"
    false
  else
    generators.generateAll('todo', main.run)
    true

