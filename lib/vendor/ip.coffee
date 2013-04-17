ignoreRE = /^(127\.0\.0\.1|::1|fe80(:1)?::1(%.*)?)$/i
exec = require("child_process").exec
cached = undefined
command = undefined
filterRE = undefined
switch process.platform
  when "win32"
    command = "ipconfig"
    filterRE = /\bIPv[46][^:\r\n]+:\s*([^\s]+)/g
  when "darwin"
    command = "ifconfig"
    filterRE = /\binet\s+([^\s]+)/g
  else
    command = "ifconfig"
    filterRE = /\binet\b[^:]+:\s*([^\s]+)/g

exports.getIP = (callback, bypassCache) ->
  if cached and not bypassCache
    callback null, cached
    return
  exec command, (error, stdout, sterr) ->
    cached = []
    ip = undefined
    matches = stdout.match(filterRE) or []
    i = 0
    while i < matches.length
      ip = matches[i].replace(filterRE, "$1")
      cached.push ip  unless ignoreRE.test(ip)
      i++
    callback error, cached