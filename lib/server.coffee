querystring = require 'querystring'
fs = require 'fs'
http = require('http')
request = require('request')
{Runner} = require './test-runner'

exports.Server = http.createServer (req,res) ->

  [url,query] = req.url.split("?")
  query = querystring.parse(query)

  switch url
    when "/start"
      Runner.start query.browsers.split("|"), query.page, query.endpoint
      res.end()
    when "/report"
      data = ""
      req.on "data", (chunk) ->
        data += chunk.toString()
      req.on "end", ->
        Runner.report JSON.parse(data), ->
          res.end()
    when "/run"
      res.writeHead(200, {'Content-Type': 'text/html'})
      res.end(fs.readFileSync('test.html'))
