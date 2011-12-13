#Page

#to indicate that a DragDroppable
#component requires jquery
#in designer view
#drag a jquery object into
#the head container 
#for the page stand-in
#so there is a mechanism
#to fypeind the parent parent
#which is a page or other object
#and marked as a standin

#htmlpage defined
#as a series
#of containers
#head is first and its a series
#body is also a series



types.add [

  htmlopentag:
    outputs: '<', "{tagname}", '>'

  htmlclosetag:
    outputs: '</', "{tagname}", '>'

  htmlelement:
    outputs:
      "{htmlopentag}"
      "{contents}"
      "{htmlclosetag}"
    contents:
      isA: 'list htmlelement'
]

data.add [
  body:
    isA: 'htmlelement'
    tagname: 'body'

  html:
    isA: 'htmlelement'
    tagname: 'html'
    contents: 'body'
    
  doctype:
    isA: 'htmlelement'
    tagname: '!doctype html'
 
  htmlpage:
    html: 'html'
    outputs: [ "{doctype}", "{html}" ]
      

]

#open tagname close
#open tagname attributes close
#  contents
#openstop tagname close


#purpose of all of this is
#to make it easy to output
#html pages
#based on page/component definitions
#using a data-oriented approach
#so that only core has
#to be ported to other platforms
#while models, components and data
#don't have to be ported

#can you get it to just output an html page
#with a head, title, body 'hello world'
#based on this more general model
#which might be page

#how to I associate
#page with html page
#say its a view

pageviewer:
  type: 'page'
  context: 'html'
  generator: 'htmlpage'

mypage:
  isA: 'page'
  contents: [
    text: 'Hello World.'
  ]

view 'mypage' 'html'

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
 

