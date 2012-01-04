
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

  
