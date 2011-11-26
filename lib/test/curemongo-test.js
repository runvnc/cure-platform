(function() {
  var assert, curemongo, util, vows;
  vows = require('vows');
  assert = require('assert');
  curemongo = require('../mongo');
  util = require('util');
  vows.describe('Cure Mongo module').addBatch({
    'A test database': {
      topic: function() {
        return curemongo.getDB('test');
      },
      'returns an object': function(db) {
        assert.isObject(db);
      },
      topic: function() {
        var db;
        db = curemongo.getDB('test');
        try {
          db.dropCollection('chairs', function() {
            return db.createCollection('chairs', this.callback);
          });
        } catch (e) {

        } finally {
          db.createCollection('chairs', this.callback);
        }
      },
      'made a collection named chairs': function(err, res) {
        assert.isNull(err);
        assert.include(res, 'collectionName');
        return assert.equal(res.collectionName, 'chairs');
      },
      'after inserting a chair': {
        topic: function(chairs) {
          return chairs.insert({
            wood: 'mahogany',
            style: 'victorian'
          });
        },
        'now contains the mahagony chair': function(err, res) {
          assert.isNull(err);
          return assert.isTrue((res.find({
            wood: 'mahogany'
          }).toArray().length) > 0);
        }
      }
    }
  })["export"](module);
}).call(this);
