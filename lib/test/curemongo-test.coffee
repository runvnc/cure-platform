vows = require 'vows'
assert = require 'assert'
curemongo = require '../mongo'
util = require 'util'

vows
  .describe('Cure Mongo module')
  .addBatch
    'A test database':
      topic: ->
        curemongo.getDB 'test'
    
      'returns an object': (db) ->
        assert.isObject db
        return
  
      topic: ->
        db = curemongo.getDB 'test'
        try
          db.dropCollection 'chairs', ->
            db.createCollection 'chairs', @callback
        catch e
        finally
          db.createCollection 'chairs', @callback
        return
      
      'made a collection named chairs': (err, res) ->
        assert.isNull err
        assert.include res, 'collectionName'
        assert.equal res.collectionName, 'chairs'
      
      'after inserting a chair':
        topic: (chairs) ->
          chairs.insert
            wood: 'mahogany'
            style: 'victorian'
        
        'now contains the mahagony chair': (err, res) ->
          assert.isNull err
          assert.isTrue ( res.find({wood:'mahogany'}).toArray().length ) > 0
    
  .export module

