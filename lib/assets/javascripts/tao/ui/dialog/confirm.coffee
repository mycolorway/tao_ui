class Tao.Dialog.Confirm extends Tao.Dialog.Message

  @tag 'tao-confirm-dialog'

  _bind: ->
    super

    @on 'click', '.button-cancel', (e) =>
      @trigger 'tao:cancel'
      @active = false
      null

TaoComponent.register Tao.Dialog.Confirm
