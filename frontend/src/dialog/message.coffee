import DialogElement from './element'

class MessageDialogElement extends DialogElement

  @tag 'tao-message-dialog'

  _bind: ->
    super()

    @on 'click', '.button-confirm', (e) =>
      @namespacedTrigger 'confirm'
      @active = false
      null

export default MessageDialogElement.register()
