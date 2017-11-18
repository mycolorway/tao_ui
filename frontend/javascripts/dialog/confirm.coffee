import MessageDialogElement from './message'

class ConfirmDialogElement extends MessageDialogElement

  @tag 'tao-confirm-dialog'

  _bind: ->
    super()

    @on 'click', '.button-cancel', (e) =>
      @namespacedTrigger 'cancel'
      @active = false
      null

export default ConfirmDialogElement.register()
