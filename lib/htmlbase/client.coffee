
#startexports
doctype = (x) -> doctype_ x

html = (x) -> html_ x

head = (x) -> head_ x

body = (x) -> body_ x

input = (x) -> input_ x

h1 = (x) -> h1_ x

p = (x) -> p_ x

text = (x) -> text_ x

title = (x) -> title_ x

script = (x) -> script_ x

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

expressapp = (func) ->
  func()
  
