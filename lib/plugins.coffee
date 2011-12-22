#read the plugins coffee file
#require it

#for each plugin
#require each file in that directory

fs = require 'fs'

exports.load = (callback) ->
  plugins = require 'plugins'
  numleft = plugins.length

  finishedfiles = ->
    numleft -= 1
  if numleft is 0 then callback()

  for plugin in plugins
    fs.readdir './' + plugin + '/', (err, files) ->
      for file in files
        require './' + plugin + '/' + file
      finishedfiles

