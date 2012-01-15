#startexports

topjs = (func) ->
  tojs fs.readFileSync("#{__dirname}/form/cstop.coffee").toString()
  func?()
  
midjs = (func) ->
  tojs fs.readFileSync("#{__dirname}/form/csmid.coffee").toString()
  func?()

bottomjs = (func) ->
  tojs fs.readFileSync("#{__dirname}/form/csbottom.coffee").toString()
  func?()

scriptfooter = ->
  topjs()
  midjs()
  bottomjs()

expressapp = (func) ->
  func()
  topjs()
  midjs()
  bottomjs()
