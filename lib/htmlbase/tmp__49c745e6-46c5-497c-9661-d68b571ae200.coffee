util = require 'util'
gen = require '../generators'
{doctype, title, html, head, body, script, span, div, style, h1, h2, h3, ul, li, dl, dd, dt, table, tr, thead, td, th, tbody, tfoot, colgroup, input, text} = gen.dk
{ replacedeferred,deferred,defer,mustinclude} = gen.generators.server.funcs
#gen = require '../generators'
#{doctype, title, html, head, body, script, input, text} = gen.dk
#{ defer, mustinclude } = gen.generators.server.funcs

#startexports
htmlpage = (title_, contentsfunc) ->
  text "apage = ->\n" +
       "  htmlpage '"+title_+"', '#{contentsfunc()})'\n"

  text "app.get '/#{title_}', (req, res) ->\n" +
       "  res.render '#{title_}'\n"

console.log "=============================== hello from server"

#gen.addAll 'server', { htmlpage:htmlpage }
gen.addAll 'server', {htmlpage:htmlpage}