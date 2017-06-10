class Tao.SlideBox.ElementBase extends TaoComponent

  @tag 'tao-slide-box'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'withCloseButton', 'autoHide', 'autoDestroy', type: 'boolean'

  @attribute 'triggerSelector', 'triggerTraversal'

  @attribute 'direction', default: 'btt'

  @attribute 'size'

  _connected: ->
    @triggerEl = if @triggerTraversal && @triggerSelector
      @jq[@triggerTraversal]?(@triggerSelector)
    else if @triggerSelector
      $ @triggerSelector

    @_initSize()
    @_bind()
    @_activeChanged() if @active

  _disconnected: ->
    @triggerEl?.off ".tao-slide-box-#{@taoId}"
    @off()
    $(document).off ".tao-select-#{@taoId}"

  _initSize: ->
    sizeProperty = if @direction in ['btt', 'ttb'] then 'height' else 'width'
    @jq[sizeProperty] if (size = parseFloat(@size)) < 0
       $(window)[sizeProperty]() + size
    else
      @size

  _bind: ->
    @on 'click', '> .link-close', =>
      @active = false

    if @triggerEl && @triggerEl.length > 0
      @triggerEl.on "click.tao-slide-box-#{@taoId}", (e) =>
        @active = true

  _beforeActiveChanged: (active) ->
    if active
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
    @_unbindAutoHideEvent() if @autoHide
    if @active
      @_bindAutoHideEvent() if @autoHide
      $('body').addClass('slide-box-active')
      @trigger 'show'
    else
      $('body').removeClass('slide-box-active')
      @trigger 'hide'

  _autoHideEvent: ''

  _unbindAutoHideEvent: ->
    $(document).off "#{@_autoHideEvent}.tao-slide-box-#{@taoId}"

  _bindAutoHideEvent: ->
    $(document).on "#{@_autoHideEvent}.tao-slide-box-#{@taoId}", (e) =>
      return if e.target == @ || $.contains(@, e.target) || @triggerEl?.is(e.target)
      @active = false
      @_unbindAutoHideEvent()
