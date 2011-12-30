
gen = require '../generators'
{doctype, title, html, head, body, script, input} = gen.dk
{ defer, mustinclude } = gen.generators.client.funcs

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
  

gen.addAll 'client', { headitems:headitems, htmlhead:htmlhead, htmlpage:htmlpage, jquery:jquery, entryfield:entryfield, entryfields: entryfields }

