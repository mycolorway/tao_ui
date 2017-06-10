class Tao.Dialog.Element extends TaoComponent

  @tag 'tao-dialog'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'modal', 'withCloseButton', 'autoDestroy', type: 'boolean'

  @attribute 'triggerSelector', 'triggerTraversal', 'size'

  _connected: ->
    @triggerEl = if @triggerTraversal && @triggerSelector
      @jq[@triggerTraversal]?(@triggerSelector)
    else if @triggerSelector
      $ @triggerSelector

    @_bind()
    @_activeChanged() if @active

  _disconnected: ->
    @triggerEl?.off ".tao-slide-box-#{@taoId}"
    @off()

  _bind: ->
    @on 'click', (e) =>
      @active = false if e.target == @

    @on 'click', '.tao-dialog-wrapper > .link-close', =>
      @active = false

    if @triggerEl && @triggerEl.length > 0
      @triggerEl.on "click.tao-slide-box-#{@taoId}", (e) =>
        @active = true

  _beforeActiveChanged: (active) ->
    if active
      @jq.find('.tao-dialog-content').css
        maxHeight: $(window).height() - 40
      @jq.show()
      @_reflow()
    else
      @one 'transitionend', =>
        if @autoDestroy
          @jq.remove()
        else
          @jq.hide()
    null

  _activeChanged: ->
    if @active
      $('body').addClass('dialog-active')
      @trigger 'show'
    else
      $('body').removeClass('dialog-active')
      @trigger 'hide'

  setContent: (content) ->
    @jq.find('.tao-dialog-content').empty()
      .append content

TaoComponent.register Tao.Dialog.Element
