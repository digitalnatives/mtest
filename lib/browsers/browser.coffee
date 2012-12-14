{spawn}   = require 'child_process'

exports.Browser = class Browser
  start: (url, callback)->
    args = @ARGS.slice()
    args.push(url)
    child = spawn @command(), args
    callback child
  teardown: ->