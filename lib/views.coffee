objects = {}

class Thing
  @find (prop, val) ->
    propmatches = prop for prop in @ when @[prop]? and @[prop] is val
    if propmatches? and propmatches.length > 0
      propmatches
    else
      obj for obj in objects when obj[prop]? and obj[prop] is val
  
  @findfirst (prop, val) ->
    first find prop, val

  @first (arr) ->
    arr[0]

  @parseid (text, func) ->
    if text.substr(0) == '{'
      name = o.substr(1)
      name = name.substr(0, name.length-1)
      @[name][func]()
    else
      text
    

  @generate (obj) ->
    outs = o for o in outputs
    if o.substr(0) == '{'
      name = o.substr(1)
      name = name.substr(0, name.length-1)
      #o2 =  
    else
      

  @view (context) ->
    view = @find @type context
    view.generate @

#when I call view how do I lookup the correct generator
#and then generate the code
#lookup the object
#what is the type
#once I know the type
#find a view for that type and context
#need a way to search through objects
#to match a certain property value

#once I find that view
#then I need to generate the outputs
#how does one generate outputs?
#look at the outputs array
#for each item, generate
#to generate an item
#if its literal text, output that text to current context stream
#if its in curly braces, lookup that item
#then call output on that object

  

#lookup ->
  
