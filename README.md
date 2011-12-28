Cure Platform
===============
Cure is a (web-based) Node.js data and content management platform with a plugin and component architecture.  

The ubiquitous to-do application:

```coffeescript
remaining = ->
  and: [
    archived: no
    done: no
  ]

exports.run = ->
  htmlpage 'todo.html', ->
    entryfield todo.description
    entrybutton todo, 'add'
    linebreak
    count todo, remaining
    text ' remaining'
    actionbutton ->
      update todo, { done: yes },
        archived: yes
    linebreak
    list todo,
      criteria:
        archived: no
      template: ->
        entryfield todo.done
        showfield todo.description
```

