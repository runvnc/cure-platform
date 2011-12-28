Cure Platform
===============
Cure is a (web-based) Node.js data and content management platform with a plugin and component architecture.  

The ubiquitous to-do application:

```coffeescript
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
```

