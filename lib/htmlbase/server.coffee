{html, head, body, text} = dk = require('drykup')()
generators = require '../generatorsdry'

htmlpage = (title_, contentsfunc) ->
    text "apage = ->\n" +
         "  htmlpage '"+title_+"', '" + contentsfunc() +"'\n"

    text "app.get '/#{title_}', (req, res) ->\n" +
         "  res.render '#{title_}'\n"


