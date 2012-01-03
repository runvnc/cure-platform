util = require 'util'
gen = require '../generators'
{doctype, title, html, head, body, script, span, div, style, h1, h2, h3, ul, li, dl, dd, dt, table, tr, thead, td, th, tbody, tfoot, colgroup, input, text} = gen.dk
{ replacedeferred,deferred,defer,mustinclude} = gen.generators.client.funcs
console.log '$$$$$$$$$$$$$$$$$$$$$$$$$$$ loading client.coffee'

#gen = require '../generators'
#{doctype, title, html, head, body, script, input} = gen.dk
#{ defer, mustinclude } = gen.generators.client.funcs


console.log "^^^^^^^^^^^^^^^^^^^^^^^#{util.inspect gen.generators.client.funcs}"
util = require 'util'

#startexports
headitems = []
entryfields = {}

htmlhead = (title_) ->
  head ->
    title title_
    for item in headitems
      (item() for item in headitems).join() if headitems?

htmlpage = (title_, contents) ->
  doctype 5
  html ->
    defer ->
      htmlhead title_
         
    body ->
      contents()

jquery = ->
  script src: 'js/jquery.js', ->

inputentry = (name, type) ->
  mustinclude headitems, jquery
  input
    type: type
    name: name
    id: "#{name}_"

entryfield = (field) ->
  if entryfields[field.type]? then entryfields[field.type](field.name)

entryfields =
  boolean: (name) ->
    inputentry  name, 'checkbox'
  text: (name) ->
    inputentry name, 'text'
  

#gen.addAll 'client', { headitems:headitems, htmlhead:htmlhead, htmlpage:htmlpage, jquery:jquery, entryfield:entryfield, entryfields: entryfields }
gen.addAll 'client', {headitems:headitems,entryfields:entryfields,htmlhead:htmlhead,htmlpage:htmlpage,jquery:jquery,inputentry:inputentry,entryfield:entryfield,entryfields:entryfields}