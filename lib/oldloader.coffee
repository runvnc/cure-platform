fs = require 'fs'
plugins = require './plugins'
generators = require './generators'
#cs = require 'coffee-script'
uuid = require 'node-uuid'
util = require 'util'
pathx = require 'path'

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
  if not file? or file is '.' or file is '..' then return ''
  file = dropext file
  source = (source + " ").trim()
  top = fs.readFileSync "#{__dirname}/includes/all.coffee"
  top = (top + " ").trim() + "\n"
  inc = ''
  if pathx.existsSync "#{__dirname}/includes/#{file}.coffee"
    inc = fs.readFileSync "#{__dirname}/includes/#{file}.coffee"
  declares = ''
  if generators.generators[file]?
    funcs = generators.generators[file].funcs
    if funcs? and Object.keys(funcs)? and Object.keys(funcs).length > 0
      declares = '{ ' + Object.keys(funcs).join() + '}'
      declares = "#{declares} = gen.generators.#{file}.funcs\n"
  bounds = "#startexports\n"
  bottom = ''
  start = source.indexOf bounds
  if start >= 0
    exports = source.substr(start + bounds.length)
    defs = exports.match /^[a-z0-9]+[ ]*[=]+/gmi
    if defs?
      list = ("#{strip def}:#{strip def}" for def in defs)
      bottom = "gen.addAll '#{file}', {#{list.join()}}"
  else
    console.log "No #startexports in #{file}"
    return ''
  top + inc + "\n" + declares + source + "\n" + bottom

process = (path, fname) ->
  if not pathx.existsSync "#{path}/#{fname}"
    false
  else
    stats = fs.statSync "#{path}/#{fname}"
    if stats.isDirectory() then return false
    source = fs.readFileSync "#{path}/#{fname}"
    source = wrap source, fname
    tmpname = "#{path}/tmp__#{fname}_#{uuid.v4()}"
    fs.writeFileSync tmpname + '.coffee', source
    r = require tmpname
    fs.unlinkSync tmpname + '.coffee'

loadall = (plugin) ->
  path = "#{__dirname}/#{plugin}"
  files = fs.readdirSync path
  for f in files when f isnt 'types.coffee' and f isnt 'main.coffee' and f.indexOf('tmp__') isnt 0
    process path, f
  generators.makeFunctions()

addgenfunctions = ->
  funcs = generators.functions
  declares = ''
  if funcs? and Object.keys(funcs)? and Object.keys(funcs).length > 0
    declares = '{ ' + Object.keys(funcs).join() + '}'
    declares = "#{declares} = gen.functions\n"
  declares

loadalltypes = (list) ->
  source = ''
  list.push 'main'
  for pl in list
    path = "#{__dirname}/#{pl}/types.coffee"
    if pathx.existsSync(path)
      source += fs.readFileSync path
  top = fs.readFileSync "#{__dirname}/includes/all.coffee"
  top = (top + " ").trim() + "\n"
  source += top
  source += addgenfunctions()
  source += fs.readFileSync "#{__dirname}/main/main.coffee"
  tmpname = "#{__dirname}/main/tmp__#{uuid.v4()}"
  fs.writeFileSync tmpname + '.coffee', source
  tmpname

exports.load = ->
  generators.makeFunctions()
  list = ((firstprop plugin) for plugin in plugins when firstval(plugin) is on)
  loadall pl for pl in list
  maintmp = loadalltypes list
  loadall 'main'
  main = require maintmp
  fs.unlinkSync "#{maintmp}.coffee"
  if not main.run?
    console.log "Loader error: main must export run()"
    false
  else
    generators.generateAll('app', main.run)
    true
