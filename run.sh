#!/bin/bash
cd mongodb*
cd bin
echo "Starting mongod (or trying)"
nohup ./mongod &
cd ../..
echo Starting application
touch themes/default/public/mobile/default.appcache
node app.js
