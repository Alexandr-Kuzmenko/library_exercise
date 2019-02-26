$(document).on 'turbolinks:load', ->
  $(document).ready ->
#    $('textarea').focusin ->
#      $(this).attr 'rows', '8'
#      return
#    $('textarea').focusout ->
#      $(this).removeAttr 'rows'
#      return
     $('textarea').focusin ->
       $(this).height 150
       return
     $('textarea').focusout ->
       $(this).height 45
       return
