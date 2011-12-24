vows = require 'vows'
{ Feature } = require 'vows-bdd'
zombie = require 'zombie'
loader = require "#{__dirname}/../lib/loader"
util = require 'util'
path = require 'path'
assert = require 'assert'

Feature("Generating todo application")
  .scenario("Basic todo app generate")

  .given "Loader is defined", ->
    r = loader?
    @callback()
    return r

  .when "I call load", ->
    console.log util.inspect loader
    console.log 'calling it'
    ret = loader.load()
    @callback()
    ret

  .then "I should see html in views/todo", ->
    assert.ok path.existsSync("#{__dirname}/../views/todo.html")
    true

  .complete()
  .finish(module)


