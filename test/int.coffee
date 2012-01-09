vows = require 'vows'
{ Feature } = require 'vows-bdd'
zombie = require 'zombie'
loader = require "#{__dirname}/../lib/loader"
util = require 'util'
path = require 'path'
assert = require 'assert'
dbx = require "#{__dirname}/../lib/db/db.coffee"
db = dbx.db

things = null

Feature("DB access and security check")
  .scenario("Wrap Deadbeef with security check")

  .given "Things collection", ->
    things = db.collection 'things'
    @callback()

  .when "I insert an apple", ->
    apple = { name: 'apple' }
    ret = things.insert apple
    things.findOne apple, @callback

  .then "Things contains at least one", (err, apple) ->
    assert.ok apple

  .complete()
  .finish(module)

