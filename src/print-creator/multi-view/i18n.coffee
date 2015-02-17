I18n = require '../../components/i18n'
Vue = require 'vue'

i18n = I18n.get kintone.getLoginUser().language, require('./dic')

# translation filter
Vue.filter 't', (v) ->
  i18n.translate v

module.exports = ->
  i18n.translate.apply i18n, arguments

module.exports.setLocale = ->
  i18n.setLocale.apply i18n, arguments
