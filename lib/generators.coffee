{html, head, body, text} = dk = require('drykup')()

exports.dk = dk

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
  uuid = uuid.guid()
  deferred[uuid] = args
  ret = '{def' + uuid + '}'
  text ret

replacedeferred = (rendered) ->
  defers = rendered.match /\{def.+\}/gi

  if defers? then for found in defers
    uuid = found.substr(4)
    uuid = uuid.substr(0, uuid.length-1)
    dk.resetHtml()
    deferred[uuid]()
    rendered = rendered.replace(found, dk.htmlOut)
  rendered
    
deferredtemplate =  ->
  replacedeferred rendered, deferred

class FileGenerator
  constructor: (@name, @path) ->
    @funcs = {}

  add: (funcs) ->
    @funcs = mergeover @funcs, funcs
  
  run: (name, func) ->
    dk.resetHtml()
    setContext @name
    func()
    output = dk.htmlOut
    newout = replacedeferred output
    ret = fs.writeFileSync("#{@path}/#{name}", newout)

generators =
  client: new FileGenerator 'client', 'views'
  server: new FileGenerator 'server', '.'


addToAll = (funcs) ->
  for name, gen of generators
   gen.add funcs

exports.generators = generators

mustinclude = (items, item) ->
  if not (item in items)
    items.push item
  else
   console.log 'not adding item'

addToAll
  replacedeferred: replacedeferred
  deferred: deferred
  defer: defer
  mustinclude: mustinclude

setContext = (context) ->
  exports.context = context

exports.setContext = setContext

addfunc = (name, func) ->
  exports.functions[name] = (allargs...) ->
    funcs = generators[exports.context].funcs
    if funcs[name]?
      funcs[name](allargs...)
    else
      console.log exports.context + '.' + name + ' not defined, skipping'

exports.addAll = (gen, funcarr) ->
  mergeover generators[gen].funcs, funcarr

exports.makeFunctions = ->
  exports.functions = {}
  for generator, val of generators
    for funcname, func of val.funcs
      addfunc funcname, func

exports.generateAll = (name, func) ->
  for gen, generator of generators
    generator.run name, func


