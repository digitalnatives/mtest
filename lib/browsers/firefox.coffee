fs = require 'fs'
{spawn}   = require 'child_process'
{Browser} = require './browser'

# TODO temporary profile delete

class Firefox extends Browser
  @PREFS = '''
    user_pref("browser.shell.checkDefaultBrowser", false);
    user_pref("browser.bookmarks.restore_default_bookmarks", false);
    '''
  command: ->
    switch process.platform
      when "linux"
        "firefox"
      when "win32"
        process.env.ProgramFiles + '\\Mozilla Firefox\\firefox.exe'

  createProfile: (callback) ->
    console.log '   Creating temporary profile for firefox...'
    errorOutput = ""
    p = spawn @command(), ['-CreateProfile', 'test'+(+new Date())]
    p.stderr.on "data", (data) ->
      errorOutput += data.toString()
    p.on "close", =>
      match = errorOutput.match /at\s\'([^'']+)prefs.js\'/
      @path = match[1] if match
      fs.writeFileSync @path+"/perfs.js", @PERFS
      callback()

  start: (url,callback)->
    @createProfile =>
      console.log '   Starting firefox...'
      child = spawn @command(), [url,'-profile',@path]
      callback child

  teardown: ->
    console.log '   Cleaning up firefox profile...'

exports.Firefox = Firefox