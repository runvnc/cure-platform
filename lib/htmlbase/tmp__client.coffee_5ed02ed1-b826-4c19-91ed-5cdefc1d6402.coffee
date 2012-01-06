util = require 'util'
gen = require '../generators'
#{doctype, title, html, head, body, script, span, div, style, h1, h2, h3, ul, li, dl, dd, dt, table, tr, thead, td, th, tbody, tfoot, colgroup, input, text} = gen.dk
doctype_ = gen.dk.doctype
title_ = gen.dk.title
html_ = gen.dk.head
head_ = gen.dk.head
body_ gen.dk.body
script_ = gen.dk.script
span_ = gen.dk.span
div_ = gen.dk.div
style_ = gen.dk.style
h1_ = gen.dk.h1
text_ = gen.dk.text
input_ = gen.dk.input

{ replacedeferred,deferred,defer,mustinclude,outfile,newfile,currgen} = gen.generators.client.funcs
#startexports
headitems = []
entryfields = {}

htmlhead = (title_) ->
  head ->
    title title_
    for item in headitems
      (item() for item in headitems).join() if headitems?

htmlpage = (title_, contents) ->
  newfile title_
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
  console.log "&&&&&&&&&&&&&& inside of entryfield -- field is #{field}"
  if entryfields[field.type]? then entryfields[field.type](field.name)

entryfields =
  boolean: (name) ->
    inputentry  name, 'checkbox'
  text: (name) ->
    inputentry name, 'text'

html = (x) -> html_ x

head = (x) -> head_ x

body = (x) -> body_ x

h1 = (x) -> h1_ x

p = (x) -> p_ x

text = (x) -> text_ x

title = (x) -> title_ x

expressapp = (func) ->
  func()
gen.addAll 'client', {headitems:headitems,entryfields:entryfields,htmlhead:htmlhead,htmlpage:htmlpage,jquery:jquery,inputentry:inputentry,entryfield:entryfield,entryfields:entryfields,html:html,head:head,body:body,h1:h1,p:p,text:text,title:title,expressapp:expressapp}