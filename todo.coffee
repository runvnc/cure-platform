apage = ->
  htmlpage 'todo.html', 'true)'

app.get '/todo.html', (req, res) ->
  res.render 'todo.html'

