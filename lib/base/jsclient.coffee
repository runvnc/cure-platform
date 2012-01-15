#startexports

text = (x) -> text_ x

tojs  = (src) ->
  text(cureutil.tojs(src) + "\n")

