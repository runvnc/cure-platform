cs = require 'coffee-script'
fs = require 'fs'
util = require 'util'

console.log "args: #{util.inspect process.argv}"

code = fs.readFileSync process.argv[1]
code = code.toString()
console.log cs.compile code, bare: on
