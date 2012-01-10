vows = require 'vows'
{ Feature } = require 'vows-bdd'
zombie = require 'zombie'
loader = require "#{__dirname}/../lib/loader"
util = require 'util'
cureutil = require "#{__dirname}/../lib/util"
path = require 'path'
assert = require 'assert'
dbx = require "#{__dirname}/../lib/db/db"
db = dbx.db
security = require "#{__dirname}/../lib/security/security"
uuid = require 'node-uuid'


things = null
obj = null

Feature("DB access and security check")
  .scenario("Wrap Deadbeef with security check")

  .given "Object to test guard on", ->
     obj =
       test: (msg) ->
         "#{msg}."
     @callback()

  .when "I call test with a message (no guard)", ->
    ret = obj.test "test"
    @callback false, ret

  .then "Return is test.", (err, ret) ->
    assert.ok (ret is 'test.')
      
  .when "I guard * on object with return false", ->
    cureutil.guard obj, /(.*)/, 'any', -> return false
    @callback()

  .and "I call test with a message", ->
    ret = obj.test "test"
    @callback ret

  .then "Calling test returns false instead of msg", (err, ret) ->
    assert.ok (ret is false)

  .given "Things collection", ->
    things = db.collection 'things'
    @callback()

  .when "I try to insert with no permissions", ->
    test = { name: 'orange' }
    ret = things.insert test
    @callback false, ret
  
  .then "Should return false", (err, ret) ->
    assert.ok (ret is false)

  .given "I add all permissions to all on things", ->
    security.addpermission 'all', 'things', 'all'
    @callback()

  .when "I insert an apple", ->
    apple = { name: 'apple2' }  #id: uuid.v4()
    ret = things.insert apple
    things.findOne apple, @callback

  .then "Things contains the apple", (err, apple) ->
    assert.ok apple

  .complete()
  .finish(module)

