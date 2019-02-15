$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#like').click ->
      switch $('#like').html()
        when '<i class="fa fa-thumbs-up"></i>'
          $('#like').html '<i class="fa fa-thumbs-down"></i>'
          $('#like').toggleClass('btn-secondary btn-success')
          like_counter = +$('lcount').text() + 1
          $('lcount').html like_counter
          return
        when '<i class="fa fa-thumbs-down"></i>'
          $('#like').html '<i class="fa fa-thumbs-up"></i>'
          $('#like').toggleClass('btn-secondary btn-success')
          like_counter = +$('lcount').text() - 1
          $('lcount').html like_counter
          return
