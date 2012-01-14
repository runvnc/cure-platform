#startexports
expressapp = (func) ->
  text """
       nowjs = require 'now'
       everyone = nowjs.initialize app
       """
