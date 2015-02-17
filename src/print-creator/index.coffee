require './browser-deps'
Vue    = require 'vue'
css    = require './load-css'
config = require './config'
Single = require './form/single'
Batch  = require './form/batch'
Multi  = require './multi-view'
$      = global.jQuery

do ->
  'use strict'

  Vue.config.debug = config.debug

  # Single PDF
  kintone.events.on 'app.record.detail.show', (event) ->
    css.load(config.css)
    $head = $ kintone.app.record.getHeaderMenuSpaceElement()
    $head.append Single.createDOM()

    event

  # Batch PDF
  kintone.events.on 'app.record.index.show', (event) ->
    if not document.getElementById('print-creator-multi')
      css.load(config.css)
      $head = $ kintone.app.getHeaderMenuSpaceElement()
      $head.append Batch.createDOM()

    event

  # Multi PDF
  kintone.events.on 'app.record.index.show', (event) ->
    if document.getElementById('print-creator-multi')
      css.load '//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'
      css.load(config.css)

      data =
        event: event
        records: event.records
        fields: [
          {
            code: 'key'   # field code
            label: 'Key'  # field title
          }
          {
            code: 'value'
            label: 'Value'
          }
        ]
        sheets: []
        selectSheetId: null
      (new Multi {data:data}).$mount '#print-creator-multi'

    event
