#!/bin/bash
set -e
echo "Generating application and testing"
vows --spec test/app.coffee

echo "Starting mongod (or trying)"
nohup mongod &
echo Starting application
#touch themes/default/public/mobile/default.appcache

echo Compiling CoffeeScript to JavaScript
coffee -c app.coffee
node app.js
