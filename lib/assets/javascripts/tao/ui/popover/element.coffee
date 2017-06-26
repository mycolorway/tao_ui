#= require ./direction
#= require ./position

{Direction, Position} = Tao.Popover

class Tao.Popover.Element extends TaoComponent

  @tag 'tao-popover'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'targetSelector', 'targetTraversal'

  @attribute 'triggerSelector', 'triggerTraversal'

  @attribute 'triggerAction', default: 'click'

  @attribute 'boundarySelector', 'direction', 'size'

  @attribute 'offset', type: 'number', default: 0

  @attribute 'autoHide', 'autoDestroy', 'withArrow', 'disabled', type: 'boolean'

  _connected: ->
    @_initTarget()
    @_initTrigger()
    @_initSize()
    @_activeChanged() if @active

  _initTarget: ->
    @target = if @targetTraversal && @targetSelector
      @jq[@targetTraversal]?(@targetSelector)
    else if @targetSelector
      $ @targetSelector

  _initTrigger: ->
    @triggerEl = if @triggerTraversal && @triggerSelector
      @jq[@triggerTraversal]?(@triggerSelector)
    else if @triggerSelector
      $ @triggerSelector
    else
      @target

    return unless @triggerEl && @triggerEl.length > 0

    if @triggerAction == 'click'
      @triggerEl.on 'click.tao-popover', (e) =>
        @toggleActive()
        null
    else if @triggerAction == 'hover'
      @triggerEl.on 'mouseenter.tao-popover', (e) =>
        @active = true
        null
      .on 'mouseleave.tao-popover', (e) =>
        @active = false
        null

  _initSize: ->
    @jq.width(@size) if @size

  _beforeActiveChanged: (active) ->
    return false if @disabled

    if active
      @jq.show()
      @refresh()
      @reflow()
    else
      reset = =>
        if @autoDestroy
          @remove()
        else
          @jq.hide()

      # in case the popover is hidden too fast
      if @jq.is(':visible')
        if @jq.css('opacity') * 1 == 0
          reset()
        else
          @one 'transitionend', ->
            reset()
    null

  _activeChanged: ->
    if @active
      @target.addClass 'tao-popover-active'
      @_enableAutoHide() if @autoHide
      @trigger 'tao:show'
    else
      @target.removeClass 'tao-popover-active'
      @_disableAutoHide() if @autoHide
      @trigger 'tao:hide'

  _enableAutoHide: ->
    $(document).on "mousedown.tao-popover-#{@taoId}", (e) =>
      return unless @active
      target = $ e.target
      return if target.is(@target) or @jq.has(target).length or target.is(@)
      @active = false
      null

  _disableAutoHide: ->
    $(document).off "mousedown.tao-popover-#{@taoId}"

  refresh: ->
    unless @direction
      direction = new Direction
        popover: @jq
        target: @target
        boundarySelector: @boundarySelector
      @direction = direction.toString()

    @position = new Position
      popover: @jq
      target: @target
      direction: @direction.split('-')
      withArrow: @withArrow
      offset: @offset

    @jq.css
      top: @position.top
      left: @position.left
    @

  resetAttributes: ->
    @active = false
    @triggerEl?.off '.tao-popover'
    @target = null
    @triggerEl = null

    for attr in _.toArray(@attributes)
      unless attr.name in ['class', 'tao-id']
        @jq.removeAttr attr.name

  setContent: (content) ->
    @jq.find('.tao-popover-content').empty()
      .append content
    @

  toggleActive: ->
    @active = !@active
    @

  beforeCache: ->
    if @autoDestroy
      @remove()
    else
      @jq.hide()
      @active = false

  remove: ->
    @trigger 'tao:beforeRemove'
    @target.removeClass 'tao-popover-active'
    @jq.remove()
    @trigger 'tao:remove'
    @

  _disconnected: ->
    @triggerEl?.off '.tao-popover'
    $(document).off ".tao-popover-#{@taoId}"

TaoComponent.register Tao.Popover.Element
