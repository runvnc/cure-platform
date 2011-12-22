ck = require 'coffeekup'
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
  console.log 'inside of defer'
  console.log 'args is ' + args
  uuid = guid()
  console.log 'guid is ' + guid
  @deferred[uuid] = args
  ret = '{def' + uuid + '}'
  console.log 'returning ' + ret
  text ret

replacedeferred = (rendered) ->
  defers = rendered.match /\{def.+\}/gi
  console.log 'deferred is ' + @deferred
  for key, val of @deferred
    console.log key + ':' + val

  for found in defers
    console.log '1'
    uuid = found.substr 4
    console.log '2'
    uuid = uuid.substr(0, uuid.length-1)
    console.log '3'
    console.log 'deferred at uuid ' + uuid + ' is ' + @deferred[uuid]
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
    output = ck.render template, deferred: deferred, hardcode: @funcs
    console.log 'output is ' + output
    output = ck.render(deferredtemplate, {deferred: deferred, rendered: output}, hardcode: @funcs)

    fs.writeFile @path + '/' + name, output, (err) ->
      if err then console.log err

generators =
  client: new FileGenerator 'client', 'views'
  server: new FileGenerator 'server', ''

generators.client.add
  replacedeferred: replacedeferred
  deferred: deferred

generators.client.add uuid

for key, val of ck
  generators.client.funcs[key] = val

exports.generators = generators

mustinclude = (items, item) ->
  console.log 'inside of mustinclude '
  console.log 'items is ' + items
  console.log 'item is ' + item
  if not (item in items)
    console.log 'adding item'
    items.push item
  else
   console.og 'not adding item'

clientfuncs =
  headitems: []

  mustinclude: mustinclude

  defer: defer

  htmlhead: (title_) ->
    console.log '***** inside of htmlhead *****'
    head ->
      title title_
      console.log 'headitems is ' + headitems
      for item in headitems
        console.log 'item is ' + item
        console.log 'return of item is ' + item()
        console.log 'ckrender of item is ' + render item, null
      (item() for item in headitems).join() if headitems?

  htmlpage: (title_, contentsfunc) ->
    doctype 5
    html ->
      defer ->
        htmlhead title_
         
      body ->
        contentsfunc()

  jquery: ->
    '<script src="js/jquery.js></script>'
    #script src: 'js/jquery.js'

  entry: (field) ->
    mustinclude headitems, jquery
    input field

serverfuncs =
  htmlpage: (title_, contentsfunc) ->
    text "apage = ->\n" +
         "  htmlpage '"+title_+"', '" + contentsfunc() +"'\n"

    text "app.get '/#{title_}', (req, res) ->\n" +
         "  res.render '#{title_}'\n"

  mustinclude: mustinclude

generators.client.add clientfuncs
generators.server.add serverfuncs


