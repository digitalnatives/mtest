{Browser} = require './browser'
{spawn}   = require 'child_process'

class IOS extends Browser
  constructor: ->
    @ARGS = ['-SimulateApplication',"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk/Applications/MobileSafari.app/MobileSafari"]
  command: ->
    switch process.platform
      when "darwin"
        "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone Simulator.app/Contents/MacOS/iPhone Simulator"

exports.IOS = IOS

