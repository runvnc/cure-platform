util = require 'util'

testfunc = (x) ->
  console.log 'callee is ' + arguments.callee
  console.log x
  console.log util.inspect @
 

console.log util.inspect testfunc()
