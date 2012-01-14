util = require 'util'
cureutil = require '../util'
gen = require '../generators'
text_ = gen.dk.text

{ replacedeferred_funcs,replacedeferred,deferred,defer_funcs,defer,mustinclude_funcs,mustinclude,outfile,newfile_funcs,newfile,currgen} = gen.generators.server.funcs
#startexports

text = (x) -> text_ x
gen.addAll 'server', {text:text}