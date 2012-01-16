#startexports
expressapp = (func) ->
  text """
       nowjs = require 'now'
       everyone = nowjs.initialize app
       everyone.now.dbinsert = (name, data) ->
           console.log "data is"
           console.log data
           db.collection(name).insert data           
           console.log "tried to call whatever"
       """
