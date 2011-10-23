#!/bin/bash

#install actual mongodb server

echo Installing actual MongoDB server

platform='unknown'
unamestr=`uname`
if [ "$unamestr" = 'Linux' ]; then
   platform='linux'
else
   platform='osx'
fi

echo Platform is $platform

if [ $platform = 'linux' ]; then
   echo Requires curl btw.
   curl http://downloads.mongodb.org/linux/mongodb-linux-i686-2.0.0.tgz > mongo.tgz
   tar xzf mongo.tgz
   sudo mkdir -p /data/db
   sudo chown `id -u` /data/db 
else
   #assume osx
   echo Requires Homebrew btw
   brew update
   brew install mongodb
fi

echo Assuming no errors so far
echo Starting mongod

cd mongodb*
cd bin
./mongod

echo Initializing database

#./mongoimport ../../dbsetup/config.json

echo Done

