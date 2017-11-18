export default {

  closeAll: ->
    $('.tao-slide-box').each (i, dialog) ->
      dialog.active = false
      null

  removeAll: ->
    $('.tao-slide-box').each (i, dialog) ->
      dialog.remove()
      null

}
