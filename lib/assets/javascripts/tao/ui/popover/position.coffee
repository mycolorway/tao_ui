
class Tao.Popover.Position extends TaoModule

  @option 'direction', 'popover', 'target'

  @option 'withArrow', default: false

  @option 'offset', type: 'number', default: 0

  @property 'arrowOffset', default: 16

  _init: ->
    @top = 0
    @left = 0
    @arrowOffset = 0 unless @withArrow

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
        @top = targetOffset.top - popoverHeight + targetHeight - parentOffset.top
      when 'bottom'
        @top = targetOffset.top - parentOffset.top
      when 'left'
        @left = targetOffset.left - popoverWidth + targetWidth - parentOffset.left
      when 'right'
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
