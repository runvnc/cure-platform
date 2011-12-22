gen = require './generatorsdry'
generators = gen.generators

{htmlpage, entry} = gen.functions

todospage = ->
  htmlpage 'To-do', ->
    entry 'todo'

generators.client.run todospage, 'todo'

