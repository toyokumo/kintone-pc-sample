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
    $form = $('<form method="POST" target="_blank"></form>')
    $data = $('<input type="hidden" name="record" value=""/>')
    $submit = $('<input type="submit" value=\"' + (t._ 'output') + '\" />')
    $data.appendTo $form
    $submit.appendTo $form
    $select.appendTo $container
    $form.appendTo $container

    # add sheets
    api.fetchSheets 0, (err, sheets) ->
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
      sheetId = $select.val()
      url = u.makeUrl "sheet/#{sheetId}/output?appCode=#{config.appCode}"
      $form.attr('action', url)
      record = kintone.app.record.get() or {record: []}
      record.recordId = kintone.app.record.getId()
      record.user = kintone.getLoginUser()
      data = JSON.stringify(record)
      $data.val data

    $container
