class Tao.Popover.Confirm extends Tao.Popover.Element

  @tag 'tao-confirm-popover'

  _connected: ->
    super

    @on 'click', '.button-confirm', (e) =>
      @trigger 'tao:confirm'
      @active = false
      null

    @on 'click', '.button-cancel', (e) =>
      @trigger 'tao:cancel'
      @active = false
      null

  setContent: (content) ->
    @jq.find('.tao-popover-content .message').empty()
      .append content
    @

TaoComponent.register Tao.Popover.Confirm
