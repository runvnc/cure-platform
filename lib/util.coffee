util = require 'util'

exports.guard = (obj, regex, category, func) ->
  for prop, val of obj when typeof val is 'function' and prop.match regex
    do (prop, val) ->
      obj[prop] = (args...) ->
        if func prop, category, args...
          console.log "Calling function args is #{util.inspect args...}"
          val.call obj, args...
        else
          false
