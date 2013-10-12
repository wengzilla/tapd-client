angular.module('filters', [])
  .filter 'truncate', ->
    (text, length, end) ->
      if $(window).width() < 480
        length = 50
      else if $(window).width() < 1024
        length = 70
      else
        length = 50

      end = "..."  if end is `undefined`
      if text? && (text.length <= length or text.length - end.length <= length)
        text
      else
        String(text).substring(0, length - end.length) + end
  .filter 'commaDelimitedNumber', -> (x) ->
    x?.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
