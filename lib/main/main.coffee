gen = require "../generators"
{htmlpage, entry} = gen.functions
util = require 'util'

exports.run = ->
  htmlpage 'To-do', ->
    entry 'todo'

