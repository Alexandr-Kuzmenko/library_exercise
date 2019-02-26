$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('a[id^="return_btn"]').click ->
      $(this).removeClass 'btn-primary'
      $(this).addClass 'btn-danger disabled'
      $(this).html 'Returned'
      return
    $('#take_book_btn').hover ->
      $(this).html 'Take book'
    $('#take_book_btn').mouseout ->
      $(this).html 'Book available'
