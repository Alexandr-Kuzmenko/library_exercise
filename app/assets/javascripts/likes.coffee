$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('div[id^="like_wrapper"]').on 'click', ->
      current_id = '#' + $(this).attr 'id'
      child_id = ' #' + $(this).find('a[id^="like"]').attr 'id'
      $(current_id).load(document.URL + child_id)
      return
