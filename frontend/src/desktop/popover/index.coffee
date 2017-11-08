import Element from './element'
import ConfirmElement from './confirm'
import create from './create'

import './styles'

closeAll = ->
  $('.tao-popover').each (i, dialog) ->
    dialog.active = false
    null

removeAll = ->
  $('.tao-popover').each (i, dialog) ->
    dialog.remove()
    null

export default { closeAll, removeAll, Element, ConfirmElement, create }
export { closeAll, removeAll, Element, ConfirmElement, create }
