exports.guard = (obj, regex, category, func) ->
  for prop, val of obj when typeof val is 'function' and prop.match regex
    do (prop, val) ->
      obj[prop] = (args...) ->
        if func prop, category, args...
          val.call obj, args...
        else
          false

exports.inseries = (funcs) ->
  (args...) ->
    ret = ''
    for func in funcs
      ret += func args...
    ret
