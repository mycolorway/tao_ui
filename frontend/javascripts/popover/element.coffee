import { Component } from '@mycolorway/tao'
import $ from 'jquery'
import _ from 'lodash'
import Direction from './direction'
import Position from './position'

class PopoverElement extends Component

  @tag 'tao-popover'

  @attribute 'active', 'disabled', type: 'boolean', observe: true

  @attribute 'targetSelector', 'targetTraversal'

  @attribute 'triggerSelector', 'triggerTraversal'

  @attribute 'triggerAction', default: 'click'

  @attribute 'boundarySelector', 'direction', 'size'

  @attribute 'offset', type: 'number', default: 5

  @attribute 'autoHide', 'autoDestroy', 'withArrow', 'autoActivate', type: 'boolean'

  _connected: ->
    @_initTarget()
    @_initTrigger()
    @_initSize()

    @on 'transitionend', @_afterTransition.bind(@)

    if @autoActivate
      @reflow()
      @active = true
    else if @active
      @_activeChanged()

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
        return if @jq.is(e.relatedTarget) || @jq.has(e.relatedTarget).length
        @active = false
        null

      @jq.on 'mouseleave', (e) =>
        return if @triggerEl.is(e.relatedTarget) || @triggerEl.has(e.relatedTarget).length
        @active = false
        null

  _initSize: ->
    @jq.width(@size) if @size

  _beforeActiveChanged: (active) ->
    return false if @disabled

    if active
      @_prepareShowTransition()
    else
      @_prepareHideTransition()

    null

  _prepareShowTransition: ->
    @namespacedTrigger 'beforeShow'
    @jq.show()
    @refresh()
    @reflow()
    @_duringTransition = 'show'

  _prepareHideTransition: ->
    @namespacedTrigger 'beforeHide'
    if @jq.is(':visible') && @jq.css('opacity') * 1 > 0
      @_duringTransition = 'hide'
    else
      @reset()

  _afterTransition: (e) ->
    return unless $(e.target).is(@) && e.originalEvent.propertyName == 'opacity'
    if @_duringTransition == 'show'
      @namespacedTrigger 'afterShow'
    else if @_duringTransition == 'hide'
      @reset()
      @namespacedTrigger 'afterHide'
    @_duringTransition = false
    null

  _activeChanged: ->
    if @active
      @target.addClass "#{@constructor._tag}-active"
      @_enableAutoHide() if @autoHide
      @namespacedTrigger 'show'
    else
      @target.removeClass "#{@constructor._tag}-active"
      @_disableAutoHide() if @autoHide
      @namespacedTrigger 'hide'

  _beforeDisabledChanged: (disabled) ->
    @active = false if disabled && @active
    null

  _enableAutoHide: ->
    $(document).on "mousedown.tao-popover-#{@taoId}", (e) =>
      return unless @active
      target = e.target
      inTarget = @target.is(target) || @target.has(target).length
      inTrigger = @triggerEl && (@triggerEl.is(target) || @triggerEl.has(target).length)
      inPopover = @jq.is(target) || @jq.has(target).length

      return if inTarget || inTrigger || inPopover
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
    @active = false if @active
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
    @reset()
    @active = false

  remove: ->
    @namespacedTrigger 'beforeRemove'
    @target.removeClass 'tao-popover-active'
    @jq.remove()
    @namespacedTrigger 'remove'
    @

  reset: ->
    if @autoDestroy
      @remove()
    else
      @jq.hide()
    @

  _disconnected: ->
    @triggerEl?.off '.tao-popover'
    $(document).off ".tao-popover-#{@taoId}"

export default PopoverElement.register()
