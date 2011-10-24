#!/bin/bash
set -u
set -e
set -x
#set -v

sudo ./node.sh

echo 'Installing Cure package and dependencies..'

npm install

#myip=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' | head -1`
#targ="http://${myip}:5984/"

#curl --header "Content-Type: application/json" --referer http://isaacs.couchone.com/_replicate -d {"source":"http://isaacs.couchone.com/registry","target":"${targ}" http://isaacs.couchone.com/_replicate

echo 'Initializing database..'

node init.js

echo Assuming everything went OK, Cure is now installed.


