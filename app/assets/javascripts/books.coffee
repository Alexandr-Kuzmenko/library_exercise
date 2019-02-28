$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('a[id^="return_btn"]').click ->
      $(this).removeClass 'btn-primary'
      $(this).addClass 'btn-danger disabled'
      $(this).html 'Returned'
      return
    $('a[id^="take_book_btn"]').hover ->
      $(this).html 'Take book'
    $('a[id^="take_book_btn"]').mouseout ->
      $(this).html 'Available'
