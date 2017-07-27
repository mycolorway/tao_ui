class Tao.Dialog.Message extends Tao.Dialog.Element

  @tag 'tao-message-dialog'

  _bind: ->
    super

    @on 'click', '.button-confirm', (e) =>
      @namespacedTrigger 'confirm'
      @active = false
      null

TaoComponent.register Tao.Dialog.Message
