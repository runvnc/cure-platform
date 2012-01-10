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
    console.log "checkobj obj is #{obj} prop is #{prop} calling it"
    func obj[prop]
  else
    console.log "checkobj fail obj is #{obj} prop is #{prop} false"
    false

checkpermission = (group, object, operation) ->
  console.log "Inside of checkpermission group is #{group} object is #{object} operation is #{operation}"
  ret = checkobj permissions[group], object, (ops) ->
    checkobj ops, operation, -> true
  if not ret
    checkobj permissions['all'], object, (ops) ->
      checkobj ops, operation, -> true
  
exports.addpermission = addpermission

exports.currentgroup = currentgroup = 'guests'

exports.dbaccess = (name, category, args...) ->
  console.log "Inside of accessdb name is #{name} category is #{category}"
  checkpermission currentgroup, category, name
