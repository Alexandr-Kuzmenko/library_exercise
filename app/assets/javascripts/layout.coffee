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

# left menu options
overlayTimer = undefined
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#menu-overlay-btn').click ->
      $('.page_content').fadeTo 500, 0.5
      $('.page_content').css
        'z-index': '-2'
      clearTimeout overlayTimer
      overlayTimer = setTimeout((->
        switch $('#menu-overlay-btn').html()
          when '\n<i class="fa fa-navicon"></i>\n'
            $('#menu-overlay-btn').html '\n<i class="fa fa-chevron-left"></i>\n'
            $('.left-overlay').width 180
            setTimeout (->
              $('.left-overlay .overlay').css
                'display': 'block';
              return
            ), 500
          when '\n<i class="fa fa-chevron-left"></i>\n'
            $('#menu-overlay-btn').html '\n<i class="fa fa-navicon"></i>\n'
            $('.left-overlay .overlay').css
              'display': 'none';
            $('.left-overlay').width 0

            $('.page_content').fadeTo 500, 1
            setTimeout (->
              $('.page_content').css
                'z-index': 'auto'
              return
            ), 500
      ), 300)
      return
    return
