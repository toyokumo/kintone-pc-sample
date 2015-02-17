_ = require 'lodash'

class I18n
  class PI18n
    locale: null
    fallbackLocale: "en"
    dic: null
    userDic: null
    table: null
    constructor: (locale = "ja", userDic = null) ->
      @dic = require './dic'
      @userDic = userDic or {}
      @setLocale locale
    setLocale: (locale) ->
      if locale isnt @locale
        @locale = locale
        @compileDic()
    compileDic: ->
      ret = {}
      for dic in [@dic, @userDic]
        for l, t of dic
          _.merge ret, t
        if @fallbackLocale of dic
          _.merge ret, dic[@fallbackLocale]
        if @locale of dic
          _.merge ret, dic[@locale]
      @table = ret
    translate: (txt) ->
      @table[txt] or txt
    t: ->
      @translate.apply @, arguments

  instance = null
  @get: (locale, userDic) ->
    if instance? and instance.locale is locale and _.isEqual(instance.userDic, userDic)
      instance
    else
      instance = new PI18n locale, userDic

    instance ?= new PI18n locale, userDic

module.exports = I18n
