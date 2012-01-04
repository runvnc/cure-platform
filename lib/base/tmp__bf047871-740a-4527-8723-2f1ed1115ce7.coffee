util = require 'util'
gen = require '../generators'
{doctype, title, html, head, body, script, span, div, style, h1, h2, h3, ul, li, dl, dd, dt, table, tr, thead, td, th, tbody, tfoot, colgroup, input, text} = gen.dk
{ replacedeferred,deferred,defer,mustinclude} = gen.generators.types.funcs
#startexports
boolean = (name) ->
  type: 'boolean'
  name: name

textfield = (name) ->
  type: 'text'
  name: name
gen.addAll 'types', {boolean:boolean,textfield:textfield}