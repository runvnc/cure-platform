q = cureutil.q

#startexports

expressapp = (func) ->
  text "security = require './lib/security/security'"

addpermission = (group, object, operation) ->
  text "security.addpermission #{q(group)}, #{q(object)}, #{q(operation)}"
