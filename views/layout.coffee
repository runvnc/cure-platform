doctype 5
html ->
  head ->
    meta charset: 'utf-8'
    title "#{@title or 'Untitled'} | A completely plausible website"

    link rel: 'stylesheet', href: '/css/app.css'

    style '''
      body {font-family: sans-serif}
      header, nav, section, footer {display: block}
    '''

    link rel: 'stylesheet', href: 'css/smoothness/jquery-ui-1.8.16.custom.css'
    script src: 'js/jquery-1.6.2.min.js'
    script src: 'js/jquery-ui-1.8.16.custom.min.js'

    coffeescript ->
      $(document).ready ->
        alert 'Alerts suck!'
  body ->
    header ->
      h1 'Page'

  div '.box', ->
    p 'first'

  div '.box', ->
    p 'second'
