{html, head, body, text} = dk = require('drykup')()

exports.dk = dk

util = require 'util'
fs = require 'fs'
uuid = require './souuid'
cs = require 'coffee-script'

mergeover = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

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
  constructor: (@name, @path, @ext = '') ->
    @funcs = {}

  add: (funcs) ->
    @funcs = mergeover @funcs, funcs
  
  run: (name, func) ->
    try
      dk.resetHtml()
      setContext @name
      func()
      output = dk.htmlOut
      newout = replacedeferred output
      ret = fs.writeFileSync("#{@path}/#{name}#{@ext}", newout)
    catch error
      console.log "File generation error. Generator name is #{@name} and path is #{@path}." +
                  "Error in #{name} function #{func}. Message is #{error}"

generators =
  client: new FileGenerator 'client', 'views', '.html'
  server: new FileGenerator 'server', '.', '.js'
#  jsclient: new FileGenerator 'jsclient', 'views'
  

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
    try
      if funcs[name]?
        funcs[name](allargs...)
      else
        console.log exports.context + '.' + name + ' not defined, skipping'
    catch error
      console.log "Generation error: name = #{name}  func = #{util.inspect func}. Error is #{error}"


exports.addAll = (gen, funcarr) ->
  mergeover generators[gen].funcs, funcarr

exports.functions = {}

exports.makeFunctions = ->
  for generator, val of generators
    for funcname, func of val.funcs
      console.log "Adding function #{funcname}"
      addfunc funcname, func

exports.generateAll = (name, func) ->
  console.log "Inside of generateAll funcs is #{console.log util.inspect generators}"
  for gen, generator of generators
    generator.run name, func

exports.include = (name) ->
  source = fs.readFileSync "./includes/#{name}.coffee"
  cs.eval source


