class Tao.SlideBox.ElementBase extends TaoComponent

  @tag 'tao-slide-box'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'autoHide', 'autoDestroy', 'modal', 'withoutPadding', type: 'boolean'

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
    size = if (size = parseFloat(@size)) < 0
      "#{$(window)[sizeProperty]() + size}px"
    else
      @size
    @jq.find('.slide-box-wrapper').css sizeProperty, size

  _bind: ->
    @on 'click', (e) =>
      @active = false if e.target == @

    @on 'click', '.slide-box-wrapper > .link-close', =>
      @active = false

    if @triggerEl && @triggerEl.length > 0
      @triggerEl.on "click.tao-slide-box-#{@taoId}", (e) =>
        @active = true

  _beforeActiveChanged: (active) ->
    if active
      @jq.show()
      @reflow()
    else
      if @jq.is(':visible')
        @one 'transitionend', =>
          if @autoDestroy
            @remove()
          else
            @jq.hide()
    null

  _activeChanged: ->
    @_unbindAutoHideEvent() if @autoHide
    if @active
      @_bindAutoHideEvent() if @autoHide
      $('body').addClass('slide-box-active')
      @trigger 'tao:show'
    else
      $('body').removeClass('slide-box-active')
      @trigger 'tao:hide'

  _autoHideEvent: ''

  _unbindAutoHideEvent: ->
    $(document).off "#{@_autoHideEvent}.tao-slide-box-#{@taoId}"

  _bindAutoHideEvent: ->
    $(document).on "#{@_autoHideEvent}.tao-slide-box-#{@taoId}", (e) =>
      return if e.target == @ || $.contains(@, e.target) || @triggerEl?.is(e.target)
      @active = false
      @_unbindAutoHideEvent()

  remove: ->
    @trigger 'tao:beforeRemove'
    @jq.remove()
    @trigger 'tao:remove'
    @

  beforeCache: ->
    if @autoDestroy
      @remove()
    else
      @jq.hide()
      active = false
