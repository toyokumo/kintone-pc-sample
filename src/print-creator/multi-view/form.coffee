Vue    = require 'vue'
t      = require './i18n'
u      = require '../utils'
api    = require '../api'
config = require '../config'
$      = global.jQuery

Form = Vue.extend
  name: 'Form'
  inherit: true
  template: require './form.html'

  computed:
    postUrl: ->
      u.makeUrl "sheet/#{@selectSheetId}/output/multi?appCode=#{config.appCode}"

    postData: ->
      data =
        records: @multiRecords
        user: kintone.getLoginUser()
      JSON.stringify data

  methods:
    onSubmit: ->
      $form = $(@$el).find 'form'
      $form.attr 'action', @postUrl
      $form.find('input[name=data]').val @postData
      true

module.exports = Form
