request   = require 'request'
{Chrome}  = require './browsers/chrome'
{IE}      = require './browsers/ie'
{Firefox} = require './browsers/firefox'
{Safari}  = require './browsers/safari'
{IOS}     = require './browsers/ios'
BROWSERS =
  chrome: new Chrome
  firefox: new Firefox
  ie: new IE
  safari: new Safari
  ios: new IOS

exports.Runner = new class Runner
  constuctor: ->

  start: (@browsers, @pages, @endpoint) ->
    console.log "Starting session >> browsers(#{@browsers}) pages(#{@pages}) endpoint(#{@endpoint})"
    @child = null
    @next()

  report: (data,callback) ->
    console.log "   Got report >> #{@currentName}:#{process.platform}  "+data
    console.log "   Sending report...."+@endpoint+"report"
    data.platform = process.platform
    data.browser = @currentName
    data.page = @currentPage
    request.post @endpoint+"report", body: JSON.stringify(data), =>
      callback()
      @nextPage()

  kill: ->
    if @child
      BROWSERS[@currentName].teardown()
      console.log "   Killing browser >> #{@currentName}:#{process.platform}"
      try
        process.kill @child.pid
      catch e

  nextPage: ->
    @kill()
    @currentPage = @currentPages.pop()
    return @next() unless @currentPage
    console.log "   Starting Browser >> #{@currentName}:#{process.platform}"
    @currentBrowser.start @currentPage, (@child) =>


  next: ->
    @kill()
    @currentPages = @pages.slice()
    @currentName = @browsers.shift()
    @currentBrowser = BROWSERS[@currentName]
    if @currentBrowser
      @nextPage()
    else
      console.log "   Calling finish...."
      request.get @endpoint+"finished", -> console.log "Session ended!"
