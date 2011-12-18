ck = require 'coffeekup'
util = require 'util'
fs = require 'fs'

mergeover = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

serv = {}
cli = {}

class FileGenerator
  constructor: (@name, @path) ->
    @funcs = {}

  add: (funcs) ->
    @funcs = mergeover @funcs, funcs
  
  run: (@template, name) ->
    output = ck.render template, hardcode: @funcs
    fs.writeFile @path + '/' + name, output, (err) ->
      if err then console.log err

generators =
  client: new FileGenerator 'client', 'views'
  server: new FileGenerator 'server', ''

generators.client.add
  require: require

mustinclude = (items, item) ->
  util = require 'util'
  console.log 'items is ' + util.inspect items
  if not (item in items)
    items.push item
  console.log 'after items is ' + util.inspect items

generators.client.add
  mustinclude: mustinclude

headitems = []

htmlhead = (title_) ->
  head ->
    title title_
    (item for item in headitems).join() if headitems?

htmlpage = (title_, contentsfunc) ->
  doctype 5
  html ->
    htmlhead title_
         
    body ->
      contentsfunc()

jquery = ->
  script src: 'js/jquery.js'

generators.client.add
  headitems: headitems
  htmlhead: htmlhead
  htmlpage: htmlpage
  jquery: jquery

generators.client.add
  entry: (field) ->
    mustinclude headitems, jquery
    input field

serverfuncs =
  htmlpage: (title_, contentsfunc) ->
    text "apage = ->\n" +
         "  htmlpage '"+title_+"', '" + contentsfunc() +"'\n"

    text "app.get '/#{title_}', (req, res) ->\n" +
         "  res.render '#{title_}'\n"


console.log util.inspect generators.client


generators.server.add
  mustinclude: mustinclude

generators.server.add serverfuncs

todospage = ->
  htmlpage 'To-do', ->
    entry 'todo'

generators.client.run todospage, 'todo'

