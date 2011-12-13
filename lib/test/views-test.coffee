vows = require 'vows'
assert = require 'assert'
util = require 'util'

vows
  .describe 'Test views infrastructure'

  .addBatch 'Objects as instances of types'
    #given a type description
    #an object described as that type
    #has the properties of that type

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


