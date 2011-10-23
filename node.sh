#!/bin/bash

echo Installing Node.js

platform='unknown'
unamestr=`uname`
if [ "$unamestr" = 'Linux' ]; then
   platform='linux'
else
   platform='osx'
fi

echo Platform is $platform

if [ $platform = 'linux' ]; then
  echo 'Assuming Ubuntu'

  ##############################################################
  #
  # Author: Ruslan Khissamov, email: rrkhissamov@gmail.com
  #
  ##############################################################

  # Add MongoDB Package
  echo 'Add MongoDB Package'
  echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list
  apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
  echo 'MongoDB Package completed'

  # Update System
  echo 'System Update'
  apt-get -y update
  echo 'Update completed'
  # Install help app
  apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++
  # Download & Unpack Node.js - v. 0.4.12
  echo 'Download Node.js - v. 0.4.12'
  mkdir /tmp/node-install
  cd /tmp/node-install
  wget http://nodejs.org/dist/node-v0.4.12.tar.gz
  tar -zxf node-v0.4.12.tar.gz
  echo 'Node.js download & unpack completed'
  # Install Node.js
  echo 'Install Node.js'
  cd node-v0.4.12
  ./configure && make && make install
  echo 'Node.js install completed'
  # Install Node Package Manager
  echo 'Install Node Package Manager'
  curl http://npmjs.org/install.sh | sudo sh
  echo 'NPM install completed'
  # Install CouchDB
  echo 'Install CouchDB'
  apt-get -y install couchdb
  echo 'CouchDB install completed.'

else
  echo 'Assuming OSX'


fi
