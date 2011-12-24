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

htmlpage = (title_, contentsfunc) ->
  doctype 5
  html ->
    defer ->
      htmlhead title_
         
    body ->
      contentsfunc()

jquery = ->
  script src: 'js/jquery.js', ->

entry = (field) ->
  mustinclude headitems, jquery
  input {name: field}

gen.addAll 'client', { headitems:headitems, htmlhead:htmlhead, htmlpage:htmlpage, jquery:jquery, entry:entry }

