
#startexports

savefields = {}

savefields.textfield = (fieldname, typename) ->
  tosave[typename] = $(fieldname).val()

savefield = (typename, fieldname, fieldval) ->

entrybutton = (type) ->
  for name, val in type when name.indexOf('_') isnt name.length-1
    savefield val.type, name, type.name_

    #copy from input field, checkbox etc.
    #into object


#entrybutton
#when they click the button
#add a new record
#with the data
#they entered

#for each field
#get the value
#assign it to the object
#
#save the object in the database
#before saving object check permissions


