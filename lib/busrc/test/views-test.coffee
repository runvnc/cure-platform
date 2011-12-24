vows = require 'vows'
assert = require 'assert'
util = require 'util'

#NOTE: CRAZY FUCKING IDEA: USE COFFEESCRIPT
#WORRY ABOUT SERIALIZATION AND GUI LATER
#JUST PUT GUIDS ON ALL OBJECTS

vows
  .describe 'Test views infrastructure'

  .addBatch 'Objects as instances of types'
    #given a type description
    #an object described as that type
    #has the properties of that type

   #context can have subcontext
   #html context can have server and
   #client context

   #can view/context/type relation be
   #abstracted to simply type relationship?
   #relation is htmview
   #generaltype is view
   #or generatedview
   #or serialview
   #serialview describes the order
   #that certain properties are output
   #or input as 

   #a component might relate to a page object
   #and serialization handled by the page object
   #rather than in the component

   #so the specific component doesn't know
   #about jquery
   #but some general widget component
   #must know about it
   #for example htmlentry
   #requires jquery to validate
   #on change

   #so how does the jquery eventually get included in the page?
   #the entry is included
   #the html serialview for entry
   #has a requires: jquery
   #jquery is defined as 
   #adding the script to head
   #so its a script element added to head which is a list
   #of elements
   #requires: means if that item isn't already there
   #then add it to the list specified

   #can requires: and outputs: be defined
   #as processor objects or something



  .addBatch 'Properties associated with processors'

  .addBatch 'Reference instances or properties in {}'
    #if a property value is text in curly braces
    #that means it is a lookup and gets assigned
    #either the corresponding named property
    #or the object matching that name

  .addBatch 'Walk through an object tree calling a function on all children'
    # 

  .addBatch 'Views associate generator types for each context'
    #Given an object with contents (children) of different types
    #to generate a view in a certain context
    #find the corresponding view type for that context starting with
    #the parent context, call generate and and walking through each child
    #property and child  

  .addBatch 'Generator views can generate serial output'
        

  .addBatch
    'Lookup properties and objects'
  
    #   
    topic ->
      o = new Thing
      
    test

#form validation and html/code parsing are essentially the same thing     

#input is a model also in the form of a stream or list of events

#everything can be handled as data with related types

#model types have a relation that expresses the fact that certain input event insertions
#cause changes to the model, e.g. newrecord button input event means a corresponding insertion
#in the record collection

#to generalize, inserting a record into one representation automatically creates an item
#of the corresponding type in the corresponding position in another representational tree     
#same with updates
#between these leaves we need converters


#html form<------>validate<----->internal representation<----->client code<------->server representation<------>database representation


#each representation or context is a tree of types
#types need converters to and from

#shorthand could be to use property name == type name


