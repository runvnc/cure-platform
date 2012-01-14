vows = require 'vows'
{ Feature } = require 'vows-bdd'
util = require 'util'
cureutil = require "#{__dirname}/../lib/util"
assert = require 'assert'
gen = require "#{__dirname}/../lib/generators"

obj = null
funcs = null
allfunc = null
outp = ''
out = (s) -> outp += s
result = null

Feature("Utility functions")
  .scenario("Test inseries")

  .given "A list of functions", ->
     funcs = [ ( (msg) -> out "#{msg}2" ) , ( (msg) -> out "#{msg}3" ) ]
     @callback()

  .when "I call inseries on that function ", ->
    allfunc = cureutil.inseries funcs
    console.log "allfunc is #{util.inspect allfunc}"
    @callback()

  .and "Run the function returned", ->
    console.log "allfunc is #{util.inspect allfunc}"
    console.log "about to run"
    allfunc 'x'
    console.log "outp is #{outp}"
    @callback()
      
  .then "Output reflects that both functions ran", ->
    assert.ok (outp is 'x2x3')

  .complete()

  .scenario('Test mergeover')
  .given 'An object with test function already defined', ->
    outp = ''
    obj =
      test: -> out 'first'
    @callback()

  .when 'I call mergeover with another test', ->
    props =
      test: -> out 'second'
    result = gen.mergeover obj, props
    @callback()

  .and 'run the result test function', ->
    result.test()
    @callback()

  .then 'Output shows test functions ran', ->
    console.log "outp is #{outp}"
    assert.ok (outp is 'firstsecond')
 
  .complete()
  .finish(module)

