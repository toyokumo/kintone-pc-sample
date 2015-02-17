Vue = require 'vue'
_   = require 'lodash'
api = require '../api'

MultiView = Vue.extend
  name: 'MultiView'
  template: require './index.html'

  computed:
    multiRecords: ->
      _.filter @records, (record) ->
        record.isUse

  created: ->
    # init
    _.each @records, (record) ->
      record.isUse = false

    # add sheets
    api.fetchSheets 1, (err, sheets) =>
      @sheets = sheets
      if sheets.length
        @selectSheetId = _.first(sheets).id

  components:
    'record': require './record'
    'form': require './form'

module.exports = MultiView
