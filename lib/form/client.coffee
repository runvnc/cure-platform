
#startexports
entryfields = {}

inputentry = (name, type) ->
  mustinclude headitems, jquery
  input
    type: type
    name: name
    id: "#{name}_"

entryfield = (field) ->
  if entryfields[field.type]? then entryfields[field.type](field.name)

entryfields =
  boolean: (name) ->
    inputentry  name, 'checkbox'
  text: (name) ->
    inputentry name, 'text'

entrybutton = (entity, msg) ->
  button { id: "btn#{entity.name_}" }, msg


