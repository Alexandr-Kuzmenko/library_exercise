$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#hist_coll_btn').click ->
      $('html').animate { scrollTop: $('#history_look_div').offset().top }, 2000
      return
