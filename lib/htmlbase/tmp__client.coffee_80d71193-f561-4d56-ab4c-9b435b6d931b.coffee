#util = require 'util'
#cureutil = require '../util'
#`gen = require '../generators'
#{doctype, title, html, head, body, script, span, div, style, h1, h2, h3, ul, li, dl, dd, dt, table, tr, thead, td, th, tbody, tfoot, colgroup, input, text} = gen.dk
doctype_ = gen.dk.doctype
title_ = gen.dk.title
html_ = gen.dk.head
head_ = gen.dk.head
body_ = gen.dk.body
script_ = gen.dk.script
span_ = gen.dk.span
div_ = gen.dk.div
style_ = gen.dk.style
h1_ = gen.dk.h1
text_ = gen.dk.text
input_ = gen.dk.input
button_ = gen.dk.button
p_ = gen.dk.p

{ replacedeferred_funcs,replacedeferred,deferred,defer_funcs,defer,mustinclude_funcs,mustinclude,outfile,newfile_funcs,newfile,currgen} = gen.generators.client.funcs
#startexports
doctype = (x...) -> doctype_ x...

html = (x...) -> html_ x...

head = (x...) -> head_ x...

body = (x...) -> body_ x...

input = (x...) -> input_ x...

button = (x...) -> button_ x...

h1 = (x...) -> h1_ x...

p = (x...) -> p_ x...

text = (x...) -> text_ x...

title = (x...) -> title_ x...

script = (x...) -> script_ x...

headitems = []
footerscripts = []

scriptfooter = (func) ->
  func()
  (item() for item in footerscripts.join() if footerscripts?

footerscript = (func) ->
  footerscripts.push func

jquery = ->
  script src: '//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js', ->

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
      defer ->
        scriptfooter ->
          jquery()
          script src: '/browserify.js', ->
          script src: '/app.js', ->
       
expressapp = (func) ->
  func()
gen.addAll 'htmlbase','client', {doctype:doctype,html:html,head:head,body:body,input:input,button:button,h1:h1,p:p,text:text,title:title,script:script,headitems:headitems,footerscripts:footerscripts,scriptfooter:scriptfooter,footerscript:footerscript,jquery:jquery,htmlhead:htmlhead,htmlpage:htmlpage,expressapp:expressapp}