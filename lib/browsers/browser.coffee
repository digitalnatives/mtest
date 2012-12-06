{spawn}   = require 'child_process'

exports.Browser = class Browser
  start: (url, callback)->
    args = @ARGS.slice()
    args.unshift(url)
    child = spawn @command(), args
    callback child
  teardown: ->