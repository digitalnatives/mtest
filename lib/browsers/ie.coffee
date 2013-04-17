{Browser} = require './browser'
{spawn}   = require 'child_process'

class IE extends Browser
  constructor: ->
    @ARGS = []
  command: ->
    switch process.platform
      when "win32"
        process.env.ProgramFiles + '\\Internet Explorer\\iexplore.exe'

exports.IE = IE