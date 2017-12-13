class Tao.Dialog.Element extends TaoComponent


  @tag 'tao-dialog'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'modal', 'withCloseButton', 'autoDestroy', 'autoActivate', type: 'boolean'

  @attribute 'closeSelector', default: '.remove-dialog'

  @attribute 'triggerSelector', 'triggerTraversal', 'size'

  _connected: ->
    @wrapper = @jq.find('.tao-dialog-wrapper')
    @content = @jq.find('.tao-dialog-content')
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
      @wrapper.width size

  _bind: ->
    @on 'click', (e) =>
      @active = false if @withCloseButton && e.target == @
      null

    @on 'click', ".tao-dialog-wrapper > .link-close, #{@closeSelector}", =>
      @active = false
      null

    @on 'transitionend', @_afterTransition.bind(@)

    if @triggerEl && @triggerEl.length > 0
      @triggerEl.on "click.tao-slide-box-#{@taoId}", (e) =>
        @active = true

  _beforeActiveChanged: (active) ->
    if active
      @_prepareShowTransition()
    else
      @_prepareHideTransition()
    null

  _prepareShowTransition: ->
    @namespacedTrigger 'beforeShow'
    @content.css
      maxHeight: $(window).height() - 40
    @jq.show()
    @reflow()
    @_duringTransition = 'show'

  _prepareHideTransition: ->
    @namespacedTrigger 'beforeHide'
    if @jq.is(':visible') && @wrapper.css('opacity') * 1 > 0
      @_duringTransition = 'hide'
    else
      @reset()

  _afterTransition: (e) ->
    return unless $(e.target).is(@wrapper) && e.originalEvent.propertyName == 'opacity'
    if @_duringTransition == 'show'
      @namespacedTrigger 'afterShow'
    else if @_duringTransition == 'hide'
      @reset()
      @namespacedTrigger 'afterHide'
    @_duringTransition = false
    null

  _activeChanged: ->
    if @active
      $('body').addClass('tao-dialog-active')
      @namespacedTrigger 'show'
    else
      $('body').removeClass('tao-dialog-active')
      @namespacedTrigger 'hide'

  setContent: (content) ->
    @content.empty().append content
    @

  remove: ->
    @namespacedTrigger 'beforeRemove'
    @jq.remove()
    @namespacedTrigger 'remove'
    @

  reset: ->
    if @autoDestroy
      @remove()
    else
      @jq.hide()
    @

  beforeCache: ->
    @reset()
    active = false

TaoComponent.register Tao.Dialog.Element
