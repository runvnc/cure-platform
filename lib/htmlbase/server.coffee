fs = require 'fs'

#startexports

text = (x) -> text_ x

expressapp = (func) ->
  top = fs.readFileSync "#{__dirname}/apphead.coffee"
  bottom = fs.readFileSync "#{__dirname}/appfooter.coffee"
  text "#{top}\n"
  func()
  text "\n"
  text "#{bottom}"

htmlpage = (title_, contentsfunc) ->
  text "app.get '/#{title_}', (req, res) ->\n" +
       "  res.render '#{title_}.html'\n"




