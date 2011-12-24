gen = require '../generators'
{doctype, title, html, head, body, script, input, text} = gen.dk
{ defer, mustinclude } = gen.generators.server.funcs


htmlpage = (title_, contentsfunc) ->
  text "apage = ->\n" +
       "  htmlpage '"+title_+"', '#{contentsfunc()})'\n"

  text "app.get '/#{title_}', (req, res) ->\n" +
       "  res.render '#{title_}'\n"


gen.addAll 'server', { htmlpage:htmlpage }

