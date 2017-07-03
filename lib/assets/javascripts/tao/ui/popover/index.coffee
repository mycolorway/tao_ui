#= require_self
#= require ./element
#= require ./confirm
#= require ./create

window.TaoPopover = Tao.Popover =

  closeAll: ->
    $('.tao-popover').each (i, dialog) ->
      dialog.active = false
      null

  removeAll: ->
    $('.tao-popover').each (i, dialog) ->
      dialog.remove()
      null
