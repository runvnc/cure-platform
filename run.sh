#!/bin/bash
set -e
echo "Generating application and testing"
vows --spec test/app.coffee

echo "Starting mongod (or trying)"
nohup mongod &
echo Starting application
#touch themes/default/public/mobile/default.appcache

coffee app.coffee
