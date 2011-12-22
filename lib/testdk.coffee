dk = require('drykup')()



dk.head ->
  dk.title 'Hello World'
dk.body ->

console.log dk.htmlOut

