util = require 'util'
cs = require 'coffee-script'
colors = require 'colors'

exports.q = (arg) ->
  if typeof arg is "string"
    "'#{arg}'"
  else
    arg

exports.tojs = (cssrc) ->
  cs.compile cssrc, bare:on

exports.guard = (obj, regex, category, func) ->
  for prop, val of obj when typeof val is 'function' and prop.match regex
    do (prop, val) ->
      obj[prop] = (args...) ->
        if func prop, category, args...
          val.call obj, args...
        else
          false

pw = (width, str) ->
  if str?
    padspaces = width - str.length
  else
    padspaces = width
    str = ''
  for n in [1..padspaces]
    str += ' '
  str

shorten = (str) ->
  str = str.replace /\n/gm, '\\n'
  if str.length > 80
    str.substr(0, 80) + '...'
  else
    str

sumargs = ->
  out = []
  for arg in arguments
    switch typeof arg
      when 'function' then out.push shorten(arg.toString())
      else out.push shorten(util.inspect(arg))
  out.join()

exports.inseries = (funcs) ->
  (args...) ->
    for func in funcs when typeof func is "object" and func.func?
      console.log "#{pw 20, func.cat}".blue + "\t#{pw 20, func.name}( #{sumargs args...} )"
      func.func args...
    true

