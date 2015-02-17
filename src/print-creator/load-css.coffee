config = require './config'

module.exports =
  load: (url) ->
    if url
      styl = document.createElement('link')
      styl.rel = 'stylesheet'
      styl.type = 'text/css'
      styl.href = url
      l = document.getElementsByTagName('link')[0]
      l.parentNode.insertBefore styl, l