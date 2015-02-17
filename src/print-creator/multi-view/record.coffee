Vue = require 'vue'
u   = require '../utils'

Record = Vue.extend
  name: 'Record'
  inherit: true
  replace: true
  template: require './record.html'
  computed:
    showUrl: ->
      "/k/#{@event.appId}/show#record=#{@$data.$id.value}"
    editUrl: ->
      @showUrl + '&mode=edit'

  methods:
    getValue: (code) ->
      if @$data[code]?.value?
        @$data[code].value
      else
        null

module.exports = Record
