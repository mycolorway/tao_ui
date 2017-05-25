#= require_self
#= require_tree .

Tao.ui =

  icons: ''

  iconTag: (name, attributes={}) ->
    $("<svg><use xlink:href=\"#icon-#{name}\"/></svg>")
      .attr attributes
      .addClass "icon icon-#{name}"

Tao.Application.initializer 'icons', (app) ->
  app.on 'page-load', (page) ->
    return if $('#tao-icons').length > 0
    document.body.insertAdjacentHTML 'afterbegin', """
    <svg id="tao-icons" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="display:none">
      #{Tao.ui.icons}
    </svg>
    """
