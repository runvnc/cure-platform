fs = require 'fs'

#startexports

expressapp = (func) ->
  top = fs.readFileSync "#{__dirname}/apphead.coffee"
  bottom = fs.readFileSync "#{__dirname}/appfooter.coffee"
  text "#{top}\n"
  func()
  text "\n"
  text "#{bottom}"

htmlpage = (title_, contentsfunc) ->
  text "apage = ->\n" +
       "  htmlpage '"+title_+"', '#{contentsfunc()})'\n"

  text "app.get '/#{title_}', (req, res) ->\n" +
       "  res.render '#{title_}'\n"




