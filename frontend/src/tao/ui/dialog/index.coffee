import Element from './element'
import MessageElement from './message'
import ConfirmElement from './confirm'

export default {
  closeAll: ->
    $('.tao-dialog').each (i, dialog) ->
      dialog.active = false
      null

  removeAll: ->
    $('.tao-dialog').each (i, dialog) ->
      dialog.remove()
      null

  Element

  MessageElement

  ConfirmElement
}
