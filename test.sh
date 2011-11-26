#!/bin/bash
#touch themes/default/public/mobile/default.appcache

echo Compiling CoffeeScript to JavaScript
coffee -c app.coffee
cd node_modules/curebase
coffee -o . -c .
cd ../..
echo Running tests
jasmine-node .

