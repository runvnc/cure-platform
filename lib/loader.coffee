fs = require 'fs'
plugins = require './plugins'
generators = require './generators'
#cs = require 'coffee-script'
uuid = require 'node-uuid'
util = require 'util'


firstprop = (obj) ->
  props = (prop for prop, val of obj)
  props[0]

firstval = (obj) ->
  vals = (val for prop, val of obj)
  vals[0]

process = (path, fname) ->
  r = require "#{path}/#{fname}"
  console.log "Loading file #{fname}"
  source = fs.readFileSync "#{path}/#{fname}"
  source = "#hello world\n" + source
  tmpname = "#{path}/tmp__#{uuid.v4()}"
  fs.writeFileSync tmpname + '.coffee', source
  r = require tmpname
  fs.unlinkSync tmpname + '.coffee'

loadall = (plugin) ->
  path = "#{__dirname}/#{plugin}"
  files = fs.readdirSync path
  for f in files when f isnt 'main.coffee' and f.indexOf('tmp__') isnt 0
    process path, f

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

