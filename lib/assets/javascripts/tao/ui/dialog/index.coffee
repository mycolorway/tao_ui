#= require_self
#= require ./element
#= require ./message
#= require ./confirm

window.TaoDialog = Tao.Dialog =

  closeAll: ->
    $('.tao-dialog').each (i, dialog) ->
      dialog.active = false
      null

  removeAll: ->
    $('.tao-dialog').each (i, dialog) ->
      dialog.remove()
      null
