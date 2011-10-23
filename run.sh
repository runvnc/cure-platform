#!/bin/bash
echo "Starting mongod (or trying)"
nohup mongod &
echo Starting application
#touch themes/default/public/mobile/default.appcache
node app.js
