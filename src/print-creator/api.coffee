request = require 'superagent'
config  = require './config'
u       = require './utils'

module.exports =
  fetchSheets: (isIndex, callback) ->
    request
    .get(u.makeUrl "api/v1/ext-sheets/?appCode=#{config.appCode}&isIndex=#{isIndex}")
    .end((err, res) ->
      if callback?
        callback err, res.body
    )
  packPdf: (data, callback) ->
    jsonData = JSON.stringify(data)
    request
    .get(u.makeUrl "api/v1/pack-pdf/?data=#{jsonData}&appCode=#{config.appCode}")
    .end((err, res) ->
      if callback?
        callback err, res.body
    )
