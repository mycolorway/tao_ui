import DialogElement from './element'
import Turbolinks from 'turbolinks'


class MessageDialogElement extends DialogElement

  @tag 'tao-message-dialog'

  @attribute 'confirmUrl'

  _bind: ->
    super()

    @on 'click', '.button-confirm', (e) =>
      @namespacedTrigger 'confirm'
      @active = false
      Turbolinks.visit(@confirmUrl) if @confirmUrl
      null

export default MessageDialogElement.register()
