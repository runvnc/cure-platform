#http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
#http://stackoverflow.com/users/3560/john-millikin
S4 = ->
  (((1+Math.random())*0x10000)|0).toString(16).substring(1)

exports.S4 = S4

exports.guid = ->
   S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4()

