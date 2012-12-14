{Browser} = require './browser'

# TODO temporary user profile

class Chrome extends Browser
  constructor: ->
    @ARGS = ['--no-default-browser-check','--user-data-dir=tmp','--no-first-run']
  command: ->
    switch process.platform
      when "linux"
        "/opt/google/chrome/chrome"
      when "win32"
        process.env.LOCALAPPDATA + '\\Google\\Chrome\\Application\\chrome.exe'
      when "darwin"
      	'/Users/mbeothy/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

  teardown: ->


exports.Chrome = Chrome