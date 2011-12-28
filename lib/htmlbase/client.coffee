gen = require '../generators'
{doctype, title, html, head, body, script, input} = gen.dk
{ defer, mustinclude } = gen.generators.client.funcs

util = require 'util'


headitems = []

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

boolean = (name) ->
  input
    type: 'checkbox'
    name: name
    id: "#{name}_"

text = (name) ->
  input
    type: 'text'
    name: name
    id: "#{name}_"

entry = (atype) ->
  if not atype?
    console.log "entry(): type function parameter not specified or improperly defined."
    false
  else
    mustinclude headitems, jquery
    console.log "Trying to call #{atype}"
    atype()

gen.addAll 'client', { headitems:headitems, htmlhead:htmlhead, htmlpage:htmlpage, jquery:jquery, entry:entry, boolean:boolean, text:text }

