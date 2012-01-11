util = require 'util'

permissions = {}

addpermission = (group, object, operation) ->
  if not permissions[group]? then permissions[group] = {}
  grp = permissions[group]
  if not grp[object]? then grp[object] = {}
  ops = grp[object]
  ops[operation] = true
  
checkobj = (obj, prop, func) ->
  if obj? and (obj[prop]? or obj['all']?)
    func obj[prop]
  else
    false

checkpermission = (group, object, operation) ->
  ret = checkobj permissions[group], object, (ops) ->
    checkobj ops, operation, -> true
  if not ret
    checkobj permissions['all'], object, (ops) ->
      checkobj ops, operation, -> true
  
exports.addpermission = addpermission

exports.currentgroup = currentgroup = 'guests'

exports.dbaccess = (name, category, args...) ->
  checkpermission currentgroup, category, name
