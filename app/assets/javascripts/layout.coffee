$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('[data-toggle="popover"]').popover()
    $('[data-toggle="popover"]').click ->
      setTimeout (->
        $('.popover').popover 'hide'
      ), 2000
    $('.btn').click ->
      setTimeout (->
        $('.btn').blur()
      ), 2000
    return
