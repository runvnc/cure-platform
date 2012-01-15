
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
  (item() for item in footerscripts).join() if footerscripts?

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
  
