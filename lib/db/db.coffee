MongolianDeadBeef = require 'mongolian'

security = require '../security/security'

cook = require('YouAreDaChef').YouAreDaChef

server = new MongolianDeadBeef

db = server.db 'app'

cook(db)
  .guard /(.*)/, ->
    console.log "HELLO FROM GUARD"
    return true
    #security.dbaccess match[1], value[1]

#server = new MongolianDeadBeef

#db = server.db 'app'

exports.db = db


