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

strip = (def) ->
  def.substr(0, def.length-1).trim()

dropext = (file) ->
  file.substr 0, file.indexOf('.')

wrap = (source, file) ->
  file = dropext file
  source = (source + " ").trim()
  top = fs.readFileSync "#{__dirname}/includes/all.coffee"
  top = (top + " ").trim() + "\n"
  declares = ''
  if generators.generators[file]?
    funcs = generators.generators[file].funcs
    if funcs.length > 0
      declares = '{ ' + funcs.join() + '}'
      declares = "{#{declares}} = gen.generators.#{file}.funcs\n"
  bounds = "#startexports\n"
  bottom = ''
  start = source.indexOf bounds
  if start >= 0
    exports = source.substr(start + bounds.length)
    defs = exports.match /^(.*)[ ]*[=]+/gmi
    list = ("#{strip def}:#{strip def}" for def in defs)
    bottom = "gen.addAll '#{file}', {#{list.join()}}"
  top + declares + source + "\n" + bottom

process = (path, fname) ->
  r = require "#{path}/#{fname}"
  console.log "Loading file #{fname}"
  source = fs.readFileSync "#{path}/#{fname}"
  source = wrap source, fname
  tmpname = "#{path}/tmp__#{uuid.v4()}"
  fs.writeFileSync tmpname + '.coffee', source
  r = require tmpname
  fs.unlinkSync tmpname + '.coffee'

loadall = (plugin) ->
  path = "#{__dirname}/#{plugin}"
  files = fs.readdirSync path
  for f in files when f isnt 'main.coffee' and f.indexOf('tmp__') isnt 0
    process path, f
  generators.makeFunctions()

exports.load = ->
  generators.makeFunctions()
  loadall(firstprop plugin) for plugin in plugins when firstval(plugin) is on
  loadall 'main'
  main = require './main/main'
  if not main.run?
    console.log "Loader error: main must export run()"
    false
  else
    generators.generateAll('todo', main.run)
    true

