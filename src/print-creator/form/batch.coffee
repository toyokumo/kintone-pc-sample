$      = global.jQuery
u      = require '../utils'
t      = require '../i18n'
api    = require '../api'
config = require '../config'

module.exports =
  createDOM: ->
    # create dom
    $container = $('<div class="pcreator-container"></div>')
    $select = $('<select class="pcreator-sheets-select"></select>')
    $form = $('<form method="POST"></form>')
    $submit = $('<input type="submit" value=\"' + (t._ 'output') + '\" />')
    $submit.appendTo $form
    $select.appendTo $container
    $form.appendTo $container

    # add sheets
    api.fetchSheets 1, (err, sheets) ->
      u.log 'sheets:', sheets
      for sheet in sheets
        $op = $ "<option value=\"#{sheet.id}\">#{sheet.title}</option>"
        $select.append $op
        $select.removeAttr "disabled"
        $submit.removeAttr "disabled"
      if sheets.length  is 0
        $op = $ "<option value=\"\">" + (t._ 'sheets_not_exist') + "</option>"
        $select.append $op
        $select.attr disabled: "disabled"
        $submit.attr disabled: "disabled"

    # submit
    $form.submit ->
      data = {}
      data.user = kintone.getLoginUser()
      data.query = kintone.app.getQueryCondition()
      data.ledgerSheetId = $select.val()

      if !data.user.email
        alert (t._ 'unknown_email')
      else
        kintone.api kintone.api.url('/k/v1/records', true),
          'GET',
          app: kintone.app.getId()
          query: kintone.app.getQueryCondition() + (" limit 1 offset 501"),
          (res) ->
            if res.records.length
              alert (t._ 'invalid_query')
            else if confirm (t._ 'confirm_sending')
              api.packPdf data, (err, res) ->
                u.log 'pack-pdf:', res
                if res.message?
                  alert res.message
                else if res.error?
                  alert res.error.message
      false

    $container
