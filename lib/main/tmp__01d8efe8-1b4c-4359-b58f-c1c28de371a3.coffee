gen = require '../generators'
{doctype, title, html, head, body, script, span, div, style, h1, h2, h3, ul, li, dl, dd, dt, table, tr, thead, td, th, tbody, tfoot, colgroup, input} = gen.dk
{boolean, text} = require '../base/types'


#startexports
todo =
  done: boolean 'done'
  description: text 'description'
  archived: boolean 'archived'
gen.addAll 'types', {todo:todo}