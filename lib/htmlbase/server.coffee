#startexports

expressapp = (func) ->
  top = fs.readFileSync "#{__dirname}/htmlbase/apphead.coffee"
  bottom = fs.readFileSync "#{__dirname}/htmlbase/appfooter.coffee"
  text "#{top}\n"
  func()
  text "\n"
  text "#{bottom}"

htmlpage = (title_, contentsfunc) ->
  text "app.get '/#{title_}', (req, res) ->\n" +
       "  res.render '#{title_}.html'\n"




