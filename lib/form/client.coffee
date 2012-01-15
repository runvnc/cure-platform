
#startexports
entryfields = {}

inputentry = (name, type) ->
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
  button { id: "btnadd#{entity.name_}" }, msg
  footerscript ->
    script ->
      text "var type_#{entity.name_} = #{JSON.stringify entity}\n"
      text "wireadd(type_#{entity.name_});\n"


