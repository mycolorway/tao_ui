import Element from './element'
import ConfirmElement from './confirm'
import create from './create'

export default {
  closeAll: ->
    $('.tao-popover').each (i, dialog) ->
      dialog.active = false
      null

  removeAll: ->
    $('.tao-popover').each (i, dialog) ->
      dialog.remove()
      null

  Element

  ConfirmElement

  create
}
