config = require './config'

module.exports = utils =
# looger wrapper
  log: ->
    debug = config.debug
    if debug and console and typeof console.log is "function"
      console.log.apply console, arguments

# logger wrapper for an event object
  elog: (e) ->
    utils.log "EventLog"
    utils.log " - type: #{e.constructor.name}"
    utils.log " - targetVM:", e.targetVM
    utils.log " - target:", e.target
    utils.log " - srcElement:", e.srcElement
  round: (val, scale) ->
    s = Math.pow(10, scale)
    (Math.round val * s) / s
  round2: (val) ->
    @round val, 2
  createInitialObject: (keys, val) ->
    ret = {}
    fp = "function" is typeof val
    for key in keys
      path = key.split "."
      cur = ret
      for p in path[...path.length - 1]
        if not cur[p]?
          cur[p] = {}
        cur = cur[p]
      cur[path[path.length - 1]] = if fp
        val(key)
      else
        val
    ret

# Getter for nested object.
  get: (key, obj) ->
    path = key.split "."
    cur = obj
    for p in path[...path.length - 1]
      if cur[p]? and typeof cur[p] is "object"
        cur = cur[p]
      else
        return undefined
    cur[path[path.length - 1]]

# Setter for nested object.
  set: (key, value, obj) ->
    path = key.split "."
    cur = obj
    for p in path[...path.length - 1]
      unless cur[p]? and typeof cur[p] is "object"
        cur[p] = {}
      cur = cur[p]
    cur[path[path.length - 1]] = value

  objMap: (mappingDef, from, to, throughKeys = []) ->
    for fromKey, toKey of mappingDef
      v = utils.get fromKey, from
      utils.set toKey, v, to
    for k in throughKeys
      v = utils.get k, from
      utils.set k, v, to
    to
  isDebugUrl: ->
    loc = window?.location?.href or ""
    if loc.match /app_dev\.php/
      true
    else
      false
  getBaseUrl: ->
    ret = config.baseUrl + "/"
    if utils.isDebugUrl()
      ret += "app_dev.php/"
    ret
  makeUrl: (api) ->
    utils.getBaseUrl() + api
