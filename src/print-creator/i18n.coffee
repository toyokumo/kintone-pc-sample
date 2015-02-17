
class Trans
  translator: null
  createTranslator: (locale, dic) ->
    I18n = require '../components/i18n'
    i18n = I18n.get locale, dic
    ->
      i18n.t.apply i18n, arguments

  _: do ->
    user = kintone.getLoginUser()
    (txt) ->
      @translator ?= @createTranslator user.language, require('./dic')
      @translator txt

# Export instance
module.exports = new Trans