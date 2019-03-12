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
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#menu-overlay-btn').click ->
      switch $('#menu-overlay-btn').html()
        when '\n<i class="fa fa-navicon"></i>\n'
          $('header').css
            'z-index':'99'
          $('#menu-overlay-btn').html '\n<i class="fa fa-chevron-left"></i>\n'
          $('.left-overlay .overlay-content').show()
          $('.left-overlay .overlay').show()
          $('.left-overlay').addClass 'toggled'
          $('.left-overlay .overlay-content').fadeTo 250, 1
          $('.left-overlay .overlay').fadeTo 250, 1
        when '\n<i class="fa fa-chevron-left"></i>\n'
          $('header').css
            'z-index':'auto'
          $('#menu-overlay-btn').html '\n<i class="fa fa-navicon"></i>\n'
          $('.left-overlay .overlay-content').fadeTo 250, 0
          $('.left-overlay .overlay').fadeTo 250, 0
          setTimeout (->
            $('.left-overlay .overlay-content').hide()
            $('.left-overlay .overlay').hide()
            $('.left-overlay').removeClass 'toggled'
          ), 250
    return
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('.left-overlay .overlay').click ->
      $('#menu-overlay-btn').click()
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    setTimeout (->
        $('.alert').hide()
    ), 10000


