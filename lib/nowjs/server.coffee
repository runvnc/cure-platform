server =
  source = fs.readFileSync "#{__dirname}/appfooter.coffee"
  text source + "\n"
