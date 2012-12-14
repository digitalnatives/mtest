request   = require 'request'
{Chrome}  = require './browsers/chrome'
{IE}      = require './browsers/ie'
{Firefox} = require './browsers/firefox'
{Safari}  = require './browsers/safari'

BROWSERS =
  chrome: new Chrome
  firefox: new Firefox
  ie: new IE
  safari: new Safari

exports.Runner = new class Runner
  constuctor: ->

  start: (@browsers, @page, @endpoint) ->
    console.log "Starting session >> browsers(#{@browsers}) page(#{@page}) endpoint(#{@endpoint})"
    @child = null
    @next()

  report: (data,callback) ->
    console.log "   Got report >> #{@currentName}:#{process.platform}  "+data
    console.log "   Sending report...."+@endpoint+"report"
    data.platform = process.platform
    data.browser = @currentName
    request.post @endpoint+"report", body: JSON.stringify(data), =>
      callback()
      @next()

  kill: ->
    if @child
      BROWSERS[@currentName].teardown()
      console.log "   Killing browser >> #{@currentName}:#{process.platform}"
      try
        process.kill @child.pid
      catch e

  next: ->
    @kill()
    @currentName = @browsers.shift()
    @currentBrowser = BROWSERS[@currentName]
    if @currentBrowser
      console.log "   Starting Browser >> #{@currentName}:#{process.platform}"
      @currentBrowser.start @page, (@child) =>
    else
      console.log "   Calling finish...."
      request.get @endpoint+"finished", -> console.log "Session ended!"