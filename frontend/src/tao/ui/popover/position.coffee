import { Module } from '@mycolorway/tao'

export default class Position extends Module

  @option 'direction', 'popover', 'target'

  @option 'withArrow', default: false

  @option 'offset', type: 'number', default: 0

  _init: ->
    @top = 0
    @left = 0

    @_setPosition()
    @_setOffset()

  _setPosition: ->
    targetOffset = @target.offset()
    targetWidth  = @target.outerWidth()
    targetHeight = @target.outerHeight()
    popoverWidth  = @popover.outerWidth()
    popoverHeight = @popover.outerHeight()
    parentOffset = @popover.offsetParent().offset()

    if @withArrow
      $arrow = @popover.find('.tao-popover-arrow')
      arrowWidth = $arrow.outerWidth()
      arrowHeight = $arrow.outerHeight()
    else
      arrowWidth = 8
      arrowHeight = 8

    switch @direction[0]
      when 'left'
        @left = targetOffset.left - popoverWidth - arrowWidth - parentOffset.left
      when 'right'
        @left = targetOffset.left + targetWidth + arrowWidth - parentOffset.left
      when 'top'
        @top = targetOffset.top - popoverHeight - arrowHeight - parentOffset.top
      when 'bottom'
        @top = targetOffset.top + targetHeight + arrowHeight - parentOffset.top

    switch @direction[1]
      when 'top'
        if @withArrow
          @top = targetOffset.top - popoverHeight + targetHeight / 2 + arrowHeight * 1.5 - parentOffset.top
        else
          @top = targetOffset.top - popoverHeight + targetHeight - parentOffset.top
      when 'bottom'
        if @withArrow
          @top = targetOffset.top + targetHeight / 2 - arrowHeight * 1.5 - parentOffset.top
        else
          @top = targetOffset.top - parentOffset.top
      when 'left'
        if @withArrow
          @left = targetOffset.left - popoverWidth + targetWidth / 2 + arrowWidth * 1.5 - parentOffset.left
        else
          @left = targetOffset.left - popoverWidth + targetWidth - parentOffset.left
      when 'right'
        if @withArrow
          @left = targetOffset.left + targetWidth / 2 - arrowWidth * 1.5 - parentOffset.left
        else
          @left = targetOffset.left - parentOffset.left
      when 'center'
        @left = targetOffset.left + targetWidth / 2  - popoverWidth / 2 - parentOffset.left
      when 'middle'
        @top = targetOffset.top + targetHeight / 2  - popoverHeight / 2 - parentOffset.top

  _setOffset: ->
    return unless @offset

    switch @direction[0]
      when 'top'
        @top -= @offset
      when 'bottom'
        @top += @offset
      when 'left'
        @left -= @offset
      when 'right'
        @left += @offset
