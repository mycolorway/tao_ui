import Element from './element'
import MessageElement from './message'
import ConfirmElement from './confirm'

closeAll = ->
  $('.tao-dialog').each (i, dialog) ->
    dialog.active = false
    null

removeAll = ->
  $('.tao-dialog').each (i, dialog) ->
    dialog.remove()
    null

export default { closeAll, removeAll, Element, MessageElement, ConfirmElement }
export { closeAll, removeAll, Element, MessageElement, ConfirmElement }
