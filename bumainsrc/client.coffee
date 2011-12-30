gen = require '../generators'
{doctype, title, html, head, body, script, input} = gen.dk
{ defer, mustinclude, boolean, text } = gen.generators.client.funcs


boolean = (name) ->
  type: 'boolean'
  name: name

text = (name) ->
  type: 'text'
  name: name

todo = ->
  done: boolean 'done'
  description: text 'description'
  archived: boolean 'archived'

viewmatch entry, todo, ->
  view boolean, -> true, -> #ignore


gen.addAll 'client', { todo:todo }