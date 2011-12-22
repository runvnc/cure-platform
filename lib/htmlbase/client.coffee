{html, head, body} = dk = require('drykup')()
generators = require '../generatorsdry'

headitems = []

htmlhead = (title_) ->
  console.log '***** inside of htmlhead *****'
  head ->
    title title_
    console.log 'headitems is ' + headitems
    for item in headitems
      console.log 'item is ' + item
      console.log 'return of item is ' + item()
      console.log 'ckrender of item is ' + render item, null
    (item() for item in headitems).join() if headitems?

htmlpage = (title_, contentsfunc) ->
  doctype 5
  html ->
    defer ->
      htmlhead title_
         
    body ->
      contentsfunc()

jquery = ->
    #'<script src="js/jquery.js></script>'
    script src: 'js/jquery.js'

entry = (field) ->
    mustinclude headitems, jquery
    input field

