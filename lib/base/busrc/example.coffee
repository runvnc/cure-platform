#[enter todo here______________] <add>
#1 remaining <clean up>
#  x (struck)learn angular
#  _ build an angular app

types =
  todo: [
    done: 'boolean'
    description: 'text'
    archived: 'boolean'
  ]

data =
  collections: [ todos: 'todo' ]

views = [
  todoitem:
    type: 'todo'
    context: 'itemstyle'
    condition: [ 'done', '=', 'true' ]
    style: 'text-decoration: line-through'
  todoentry:
    type: 'todo'
    context: 'entryform'
    hidden: 'archived'
]

components =
  todo: [
    entry: 'todo'
    separator: '\n'
    count:
      collection: 'todo'
      done: false
      archived: false
    text:
      ' remaining'
    action:
      update:
      collection: 'todo'
      where:
        criteria: [ 'user', '=', currentUser, 'and', 'done', '=', 'true' ]
        set: [ archived: true ]
    list:
        collection: 'todo'
        filters: [ archived: false ]
  ]
      
pages =
  index: [ 'todo' ]
     

