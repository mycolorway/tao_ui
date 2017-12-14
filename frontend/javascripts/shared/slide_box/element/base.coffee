import $ from 'jquery'
import { Component } from '@mycolorway/tao'

export default class SlideBoxElementBase extends Component

  @tag 'tao-slide-box'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'autoHide', 'autoDestroy', 'modal', 'withoutPadding', type: 'boolean'

  @attribute 'triggerSelector', 'triggerTraversal'

  @attribute 'direction', default: 'btt'

  @attribute 'size'

  _connected: ->
    @wrapper = @jq.find('.slide-box-wrapper')
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
    @wrapper.css sizeProperty, size

  _bind: ->
    @on 'click', (e) =>
      @active = false if e.target == @

    @on 'click', '.slide-box-wrapper > .link-close', =>
      @active = false

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
    @jq.show()
    @reflow()
    @_duringTransition = 'show'
    @namespacedTrigger 'beforeShow'

  _prepareHideTransition: ->
    if @jq.is(':visible') && @wrapper.css('opacity') * 1 > 0
      @_duringTransition = 'hide'
    else
      @reset()
    @namespacedTrigger 'beforeHide'

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
    @_unbindAutoHideEvent() if @autoHide
    if @active
      @_bindAutoHideEvent() if @autoHide
      $('body').addClass('slide-box-active')
      @namespacedTrigger 'show'
    else
      $('body').removeClass('slide-box-active')
      @namespacedTrigger 'hide'

  _autoHideEvent: ''

  _unbindAutoHideEvent: ->
    $(document).off "#{@_autoHideEvent}.tao-slide-box-#{@taoId}"

  _bindAutoHideEvent: ->
    $(document).on "#{@_autoHideEvent}.tao-slide-box-#{@taoId}", (e) =>
      return if e.target == @ || $.contains(@, e.target) || @triggerEl?.is(e.target)
      @active = false
      @_unbindAutoHideEvent()

  remove: ->
    @namespacedTrigger 'beforeRemove'
    @jq.remove()
    @namespacedTrigger 'remove'
    @

  beforeCache: ->
    @reset()
    active = false

  reset: ->
    if @autoDestroy
      @remove()
    else
      @jq.hide()
    @
