
shown = ->
  and: [
    archived: false
    done: false
  ]

exports.run = ->
  addpermission 'guests', 'todo', 'all'

  expressapp ->
    htmlpage 'todo', ->
      entryfield todo.description
      entrybutton todo, 'add'
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

    htmlpage 'about', ->
      h1 'About'
      p 'Hello, this is about..'
 

