dk = require('drykup')()
util = require 'util'
fs = require 'fs'

class FileGenerator
  constructor: (@name, @path) ->
    @funcs = {}

  exec: (funcname, args) ->
    if @funcs[funcname]?
      @funcs[funcname](args)

  run: (@template, name) ->
    template @exec
    output = dk.htmlOut
    fs.writeFile @path + '/' + name, output, (err) ->
      if err then console.log err

generators =
  client: new FileGenerator 'client', 'views'
  css: new FileGenerator 'css', 'views/css'
  db: new FileGenerator 'db', ''
  nodejs: new FileGenerator 'nodejs', ''

cli = generators.client.funcs

cli.mustinclude = (items, item) ->
  if not (item in items)
    items.push item

cli.headitems = []

cli.htmlhead = (title_) ->
  dk.head ->
    dk.title title_
    (item for item in headitems).join() if headitems?

cli.htmlpage = (title_, contentsfunc) ->
  dk.doctype 5
  dk.html ->
    cli.htmlhead title_
         
    dk.body ->
      contentsfunc()

cli.jquery = ->
  dk.script src: 'js/jquery.js'

cli.entry = (field) ->
    cli.mustinclude cli.headitems, cli.jquery
    dk.input field

serv = generators.nodejs.funcs

serv.htmlpage = (title_, contentsfunc) ->
    dk.addText "apage = ->\n" +
         "  htmlpage '"+title_+"', '" + contentsfunc() +"'\n"

    dk.addText "app.get '/#{title_}', (req, res) ->\n" +
         "  res.render '#{title_}'\n"


todospage = (gen) ->
  gen 'htmlpage', 'To-do', ->
    gen 'entry', 'todo'

generators.client.run todospage, 'todo'

