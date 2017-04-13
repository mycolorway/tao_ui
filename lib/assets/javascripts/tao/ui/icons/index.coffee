#= require_self
#= require ./basic

Tao.icons = ''

Tao.Application.initializer 'icons', (app) ->
  app.on 'page-load', (page) ->
    return if $('#tao-icons').length > 0
    document.body.insertAdjacentHTML 'afterbegin', """
    <svg id="tao-icons" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="display:none">
      #{Tao.icons}
    </svg>
    """
