
#startexports
boolean = (name) ->
  type: 'boolean'
  name: name

textfield = (name) ->
  type: 'text'
  name: name

#{boolean, text} = require '../base/types'


#startexports
todo =
  done: boolean 'done'
  description: textfield 'description'
  archived: boolean 'archived'

  
#{todo} = require './types'
util = require 'util'
console.log "*** #{util.inspect todo}"

gen = require "../generators"
{htmlpage, entryfield, boolean} = gen.functions

shown = ->
  and: [
    archived: false
    done: false
  ]

exports.run = ->

  htmlpage 'todo.html', ->
    #todo = todo()
    
    console.log "OK --------- todo is #{util.inspect todo}"
    entryfield todo.description
    #entrybutton todo, 'add'
    #linebreak
    #count todo, shown
    #text ' remaining'
    #actionbutton ->
    #  update todo, { done: true },
    #    archived: true
    #linebreak
    #list todo,
    #  criteria: shown
    #  template: ->
    #    entryfield todo.done
    #    showfield todo.description
