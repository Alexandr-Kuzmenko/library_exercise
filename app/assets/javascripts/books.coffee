$(document).on 'turbolinks:load', ->
  $(document).ready ->
  $('print_field_btn').click ->
    $('.new_comment_block').toggle()
