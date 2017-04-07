#= require_self
#= require ./basic
#= require tao/ui/icons/app

Tao.icons =

  html: ''

  insertHTML: ->
    $page = $('.tao-page')
    return if $page.siblings('#tao-icons').length > 0
    $page[0].insertAdjacentHTML 'beforebegin', """
      <svg id="tao-icons" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="display:none">
        #{Tao.icons.html}
      </svg>
    """
