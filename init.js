var console = require('console');
console.log('Connecting to database');

var mongo = require('mongoskin');
var db = mongo.db('localhost:27017/app');

console.log('Initializing database..');



db.createCollection('users', function(err, collection) {
  if (err) {
    console.log('Error creating collection:');
    console.dir(err);
  } else {
    console.log('Created users');
    db.collection('users').find().toArray(function(err, items) {
      if (items && items.length > 0) {
        console.log('Users table already exists, aborting');
      } else {
        collection.insert({ username: 'admin', password: 'password' });
        console.log('Inserted admin user with password "password"');
      }
    });


 
/* 
    var t = db.collection('testcol').find().toArray(function(err, items) {
      console.dir(items);
    });
*/

  }
});

