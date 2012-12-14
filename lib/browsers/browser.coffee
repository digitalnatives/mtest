{spawn}   = require 'child_process'

exports.Browser = class Browser
  start: (url, callback)->
    args = @ARGS.slice()
    args.push(url)
    console.log args
    child = spawn @command(), args
    callback child
  teardown: ->