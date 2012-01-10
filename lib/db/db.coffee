MongolianDeadBeef = require 'mongolian'

cureutil = require '../util'

security = require '../security/security'

server = new MongolianDeadBeef

db_ = server.db 'app'

exports.db = {}

guarded = {}

exports.db.collection = (name) ->
  if not (name in guarded)
    col = db_.collection(name)
    cureutil.guard col, /(.*)/, name, security.dbaccess
    guarded[name] = col
  guarded[name]

