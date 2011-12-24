vows = require 'vows'
assert = require 'assert'
todos = require '../main/todos'

util = require 'util'

vows
  .describe('Plugins + Generators + Todo + Page')
  .addBatch
    'Todo':
      topic: ->
        result = todos.generate()
    
      'returns true': (result) ->
        assert.isTrue result
  
  .export module

