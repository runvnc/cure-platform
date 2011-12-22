{html, head, body, text} = dk = require('drykup')()

util = require 'util'
fs = require 'fs'
uuid = require './souuid'

mergeover = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

serv = {}
cli = {}

deferred = {}

defer = (args) ->
  uuid = guid()
  @deferred[uuid] = args
  ret = '{def' + uuid + '}'
  text ret

replacedeferred = (rendered) ->
  defers = rendered.match /\{def.+\}/gi

  for found in defers
    uuid = found.substr 4
    uuid = uuid.substr(0, uuid.length-1)
    rendered = rendered.replace found, @deferred[uuid]()
  text rendered
    
deferredtemplate =  ->
  replacedeferred @rendered, @deferred

class FileGenerator
  constructor: (@name, @path) ->
    @funcs = {}

  add: (funcs) ->
    @funcs = mergeover @funcs, funcs
  
  run: (@template, name) ->
    output = template()

    fs.writeFile @path + '/' + name, output, (err) ->
      if err then console.log err

generators =
  client: new FileGenerator 'client', 'views'
  server: new FileGenerator 'server', ''

generators.client.add
  replacedeferred: replacedeferred
  deferred: deferred

exports.generators = generators

mustinclude = (items, item) ->
  if not (item in items)
    items.push item
  else
   console.log 'not adding item'

#assume all plugins have loaded
#and defined functions to output
#client and server code
#now we want to wrap those functions
#so that a template can call them
#

exports.setContext = (context) ->
  exports.context = context

addfunc = (name, func) ->
  exports.functions[name] = (allargs...) ->
    if generators[exports.context][name]?
      generators[exports.context][name](allargs...)
    else
      console.log exports.context + '.' + name + ' not defined, skipping'

exports.makeFunctions = ->
  exports.functions = {}
  for generator, val of generators
    for funcname, func of val.funcs
      addfunc funcname, func

#need to require everything from list of plugins
#put them in generators.client or generators.server
#all of the functions in any plugin clients.coffee
#need to go into functions
#which is a function that calls the appropriate
#client or server function depending on the context

