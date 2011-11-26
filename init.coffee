console = require 'console'
console.log 'Connecting to database'

mongo = require 'mongoskin'
db = mongo.db 'localhost:27017/app'

console.log 'Initializing database..'

db.createCollection 'users', (err, collection) ->
  if err?
    console.log 'Error creating collection:'
    console.dir err
  else
    console.log 'Created users'
    db.collection 'users'
      .find
      .toArray (err, items) ->
        if items and items.length > 0
          console.log 'Users table already exists, aborting'
        else
          collection.insert
            username: 'admin'
            password: 'password'
          console.log 'Inserted admin user with password "password"'
    
