gen = require "../generators"
{htmlpage, entry, todo, boolean} = gen.functions

shown = ->
  and: [
    archived: false
    done: false
  ]

exports.run = ->
  htmlpage 'todo.html', ->
    entryfield todo.description
    entrybutton todo, 'add'
    linebreak
    count todo, shown
    text ' remaining'
    actionbutton ->
      update todo, { done: true },
        archived: true
    linebreak
    list todo,
      criteria: shown
      template: ->
        entryfield todo.done
        showfield todo.description
