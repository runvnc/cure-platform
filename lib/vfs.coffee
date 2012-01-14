fs = require 'fs'

tree = {}
index = {}
basepath = ''

setbase = (dirpath) ->
  basepath = dirpath
  ret = scandir exports.tree, dirpath
  fs.writeFileSync __dirname + '/vfstree.js', 'exports.tree = ' + JSON.stringify(tree)

scandir = (parentnode, dirpath) ->
  files = fs.readdirSync dirpath
  for file in files
    if file.substr(0, 1) isnt '.'
      stats = fs.statSync "#{dirpath}/#{file}"
      if stats.isDirectory()
        parentnode[file] =
          isdir: true
        parentnode[file].files = scandir parentnode[file], "#{dirpath}/#{file}"
      else
        parentnode[file] =
          isdir: false
          text: fs.readFileSync("#{dirpath}/#{file}").toString()
        index["#{dirpath}/#{file}"] = parentnode[file].text
  true

readFileSync = (pathname) ->
  index[pathname]

exports.tree = tree
exports.index = index
exports.basepath = basepath
exports.scandir = scandir
exports.readFileSync = readFileSync
exports.setbase = setbase

