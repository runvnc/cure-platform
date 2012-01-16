#startexports

bottomscripts = []

entrybutton = ->
  bottomscripts.push ->
      text "var type_#{entity.name_} = #{JSON.stringify entity}\n"
      text "wireadd(type_#{entity.name_});\n"

topjs = (func) ->
  tojs fs.readFileSync("#{__dirname}/form/cstop.coffee").toString()
  func?()
  
midjs = (func) ->
  tojs fs.readFileSync("#{__dirname}/form/csmid.coffee").toString()
  func?()

bottomjs = (func) ->
  tojs fs.readFileSync("#{__dirname}/form/csbottom.coffee").toString()
  (item() for item in bottomscripts).join() if bottomscripts?
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
