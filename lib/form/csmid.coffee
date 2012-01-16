class FormField
  constructor: (type, @record) ->
    @name = type.name
    
    @id = "##{@name}_"
    console.log "id is #{@id}"
    @type = type.type
    if type.required?
      @required = type.required
    else
      @required = false

  pullvalue: ->
    @val = $(@id).val()
    console.log "el is #{$(@id)}"
    console.log "val is #{@val}"

  validate: ->
    @pullvalue()
    if @required
      @val? and @val isnt ''
    else
      true


class TextFormField extends FormField

class BoolFormField extends FormField
  pullvalue: ->
    @val = $(@id).is(':checked')


class FormRecord
  constructor: (@type, @mode, @data = {}) ->
    @name = @type.name_
    @makeFields()

  selField: (field) ->
    switch field.type
      when 'text' then new TextFormField field, @
      when 'boolean' then new BoolFormField field, @
      when undefined then field
      else field

  makeFields: ->
    @fields = {}
    for fieldname, field of @type when fieldname.lastIndexOf('_') isnt fieldname.length-1
      @fields[fieldname] = @selField field
   
  validate: ->
    for name, field of @fields
      if not field.validate() then return false
    true
  
  save: ->
    if @validate()
      for name, field of @fields
        @data[name] = field.val
      if @mode is 'new'
        console.log "data is"
        console.log @data
        now.dbinsert @name, @data
    else
      false

wireadd = (type) ->
  recname = 'rec_'+type.name_
  rec = window[recname] = new FormRecord type, 'new'
  $("#btnadd#{type.name_}").click ->
    if rec.save()
      alert 'Saved.'
    

