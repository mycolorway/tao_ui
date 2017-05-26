
class Tao.Popover.Position extends TaoModule

  @option 'direction', 'popover', 'target'

  @option 'arrowAlign', default: 'center'

  @option 'arrowVerticalAlign', default: 'middle'

  @option 'offset', default: 0

  ARROW_OFFSET: 16

  _init: ->
    @top = 0
    @left = 0

    @_setPosition()
    @_setArrowAlign()
    @_setOffset()

  _setPosition: ->
    targetOffset = @target.offset()
    targetWidth  = @target.outerWidth()
    targetHeight = @target.outerHeight()
    popoverWidth  = @popover.outerWidth()
    popoverHeight = @popover.outerHeight()
    parentOffset = @popover.offsetParent().offset()
    $arrow = @popover.find('.tao-popover-arrow')
    arrowWidth = $arrow.outerWidth()
    arrowHeight = $arrow.outerHeight()

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
        @top = targetOffset.top - popoverHeight + targetHeight / 2 + arrowHeight / 2 + @ARROW_OFFSET - parentOffset.top
      when 'bottom'
        @top = targetOffset.top + targetHeight / 2 - arrowHeight / 2 - @ARROW_OFFSET - parentOffset.top
      when 'left'
        @left = targetOffset.left - popoverWidth + targetWidth / 2 + arrowWidth / 2 + @ARROW_OFFSET - parentOffset.left
      when 'right'
        @left = targetOffset.left + targetWidth / 2 - arrowWidth / 2 - @ARROW_OFFSET - parentOffset.left
      when 'center'
        @left = targetOffset.left + targetWidth / 2  - popoverWidth / 2 - parentOffset.left
      when 'middle'
        @top = targetOffset.top + targetHeight / 2  - popoverHeight / 2 - parentOffset.top

  _setArrowAlign: ->
    if /top|bottom/.test @direction[0]
      switch @arrowAlign
        when 'left'
          @left -= @target.width() / 2
        when 'right'
          @left += @target.width() / 2

    if /left|right/.test @direction[0]
      switch @arrowVerticalAlign
        when 'top'
          @top -= @target.height() / 2
        when 'bottom'
          @top += @target.height() / 2

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
