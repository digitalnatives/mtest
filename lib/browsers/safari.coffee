fs = require 'fs'
{Browser} = require './browser'
{spawn}   = require 'child_process'
path = require 'path'

class Safari extends Browser
  constructor: ->
    @ARGS = [path.resolve(__dirname, './safari_temp.html')]
  command: ->
    switch process.platform
      when "darwin"
        '/Applications/Safari.app/Contents/MacOS/Safari'

  start: (url, callback)->
    args = @ARGS.slice()
    html = path.resolve(__dirname, './safari.html')
    tmp_html = path.resolve(__dirname, './safari_temp.html')
    contents = fs.readFileSync(html,'utf-8').replace "{{URL}}", url
    fs.writeFileSync(tmp_html, contents)
    child = spawn @command(), args
    callback child

  teardown: ->


exports.Safari = Safari