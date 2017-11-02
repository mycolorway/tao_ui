class Tao.Dialog.Element extends TaoComponent

  @tag 'tao-dialog'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'modal', 'withCloseButton', 'autoDestroy', 'autoActivate', type: 'boolean'

  @attribute 'closeSelector', default: '.remove-dialog'

  @attribute 'triggerSelector', 'triggerTraversal', 'size'

  _connected: ->
    @triggerEl = if @triggerTraversal && @triggerSelector
      @jq[@triggerTraversal]?(@triggerSelector)
    else if @triggerSelector
      $ @triggerSelector

    @_initSize()
    @_bind()

    if @autoActivate
      @reflow()
      @active = true
    else if @active
      @_activeChanged()

  _disconnected: ->
    @triggerEl?.off ".tao-slide-box-#{@taoId}"
    @off()

  _initSize: ->
    if _.isNumber(size = parseFloat @size)
      @jq.find('.tao-dialog-wrapper').width size

  _bind: ->
    @on 'click', (e) =>
      @active = false if e.target == @
      null

    @on 'click', ".tao-dialog-wrapper > .link-close, #{@closeSelector}", =>
      @active = false
      null

    if @triggerEl && @triggerEl.length > 0
      @triggerEl.on "click.tao-slide-box-#{@taoId}", (e) =>
        @active = true

  _beforeActiveChanged: (active) ->
    if active
      @jq.find('.tao-dialog-content').css
        maxHeight: $(window).height() - 40
      @jq.show()
      @reflow()
    else
      reset = =>
        if @autoDestroy
          @remove()
        else
          @jq.hide()

      if @jq.is(':visible')
        @on 'transitionend', (e) =>
          return unless $(e.target).is('.tao-dialog-wrapper')
          @off 'transitionend'
          reset()
      else
        reset()

    null

  _activeChanged: ->
    if @active
      $('body').addClass('tao-dialog-active')
      @namespacedTrigger 'show'
    else
      $('body').removeClass('tao-dialog-active')
      @namespacedTrigger 'hide'

  setContent: (content) ->
    @jq.find('.tao-dialog-content').empty()
      .append content
    @

  remove: ->
    @namespacedTrigger 'beforeRemove'
    @jq.remove()
    @namespacedTrigger 'remove'
    @

  beforeCache: ->
    if @autoDestroy
      @remove()
    else
      @jq.hide()
      active = false

TaoComponent.register Tao.Dialog.Element
