#!/bin/bash
echo "Starting mongod (or trying)"
nohup mongod &
echo Starting application
#touch themes/default/public/mobile/default.appcache

echo Compiling CoffeeScript to JavaScript
coffee -c app.coffee
cd node_modules/curebase
coffee -o . -c .
cd ../..
node app.js
