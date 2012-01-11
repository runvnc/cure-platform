{html, head, body, text} = dk = require('drykup')()

exports.dk = dk

util = require 'util'
fs = require 'fs'
uuid = require './souuid'
cs = require 'coffee-script'
cureutil = require './util'

appendcall = (object, name, func) ->
  funcs = "#{name}_funcs"
  console.log "A"
  if object[funcs]?
    console.log "adding func"
    object[funcs].push funcs
  else
    console.log "initializing funcs"
    object[funcs] = [ func ]
  console.log "object[funcs] is now #{util.inspect object[funcs]}"
  object[name] = cureutil.inseries object[funcs]
  console.log "Done with appendcall object is now #{util.inspect object}"


mergeover = (object, properties) ->
  for key, val of properties
    if typeof val is "function"
      console.log "Calling appendcall object is #{util.inspect object} key is #{key} val is #{val}"
      appendcall object, key, val
    else
      object[key] = val
  object

outfile = null

deferred = {}

defer = (args) ->
  uuid_ = uuid.guid()
  deferred[uuid_] = args
  ret = '{def' + uuid_ + '}'
  text ret

replacedeferred = (rendered) ->
  defers = rendered.match /\{def.+\}/gi

  if defers? then for found in defers
    uuid_ = found.substr(4)
    uuid_ = uuid_.substr(0, uuid_.length-1)
    dk.resetHtml()
    deferred[uuid_]()
    rendered = rendered.replace found, dk.htmlOut
  rendered
    
deferredtemplate =  ->
  replacedeferred rendered, deferred

currgen = null

newfile = (file) ->
  if outfile?
    output = dk.htmlOut
    if output? and output.length > 0
      newout = replacedeferred output
      fs.writeFileSync "#{currgen.path}/#{outfile}#{currgen.ext}", newout
      dk.resetHtml()
  outfile = file
  dk.resetHtml()

class FileGenerator
  constructor: (@name, @path, @ext = '') ->
    @funcs = {}

  add: (funcs) ->
    @funcs = mergeover @funcs, funcs
  
  run: (name, func) ->
    try
      currgen = @
      outfile = name
      dk.resetHtml()
      setContext @name
      func()
      output = dk.htmlOut
      newout = replacedeferred output
      ret = fs.writeFileSync("#{@path}/#{outfile}#{@ext}", newout)
      
    catch error
      console.log "File generation error. Generator name is #{@name} and path is #{@path}." +
                  "Error in #{name} function #{func}. Message is #{error}"
      process.exit(1)

generators =
  client: new FileGenerator 'client', 'views', '.html'
  server: new FileGenerator 'server', '.', '.coffee'
  jsclient: new FileGenerator 'jsclient', 'views'
  types: new FileGenerator 'types', '/tmp', '.tmp'

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
  outfile: outfile
  newfile: newfile
  currgen: currgen

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
      process.exit 1

exports.addAll = (gen, funcarr) ->
  mergeover generators[gen].funcs, funcarr

exports.functions = {}

exports.makeFunctions = ->
  for generator, val of generators
    for funcname, func of val.funcs
      addfunc funcname, func

exports.generateAll = (name, func) ->
  for gen, generator of generators
    currgen = generator
    generator.funcs[currgen] = generator
    generator.run name, func

exports.include = (name) ->
  source = fs.readFileSync "./includes/#{name}.coffee"
  cs.eval source


