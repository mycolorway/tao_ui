
class Tao.Popover.Direction extends TaoModule

  @option 'popover', 'target', 'boundarySelector'

  _init: ->
    @boundary = if @boundarySelector
      @target.closest(@boundarySelector)
    else
      $(window)

    @_calculate()

  _calculate: ->
    coefficient = @_beyondCoefficient()

    vertical = if (coefficient.bottom > 0 && coefficient.top > 0) || coefficient.bottom == coefficient.top == 0
                 'middle'
               else if coefficient.bottom > 0
                 'top'
               else
                 'bottom'

    horizental = if (coefficient.left > 0 && coefficient.right > 0) || coefficient.left == coefficient.right == 0
                   if vertical == 'middle' then 'right' else 'center'
                 else if coefficient.right > 0
                  'left'
                 else
                   'right'

    @directions = if vertical == 'middle'
                    [horizental, vertical]
                  else if horizental == 'center'
                    [vertical, horizental]
                  else if coefficient[vertical] > coefficient[horizental]
                    [horizental, vertical]
                  else
                    [vertical, horizental]

  _beyondCoefficient: ->
    targetDimensions = @_getDimensions @target
    boundaryDimensions = @_getDimensions @boundary
    popoverWidth = @popover.outerWidth()
    popoverHeight = @popover.outerHeight()
    boundaryWidth = @boundary.width()
    boundaryHeight = @boundary.height()

    beyondOffset = ['left', 'right', 'top', 'bottom'].reduce (offset, name) ->
      offset[name] = targetDimensions[name] - boundaryDimensions[name]
      offset
    , {}

    {
      left: Math.max(popoverWidth - beyondOffset.left, 0) * popoverHeight + Math.max(popoverHeight - boundaryHeight, 0) * popoverWidth
      right: Math.max(popoverWidth - beyondOffset.right, 0) * popoverHeight + Math.max(popoverHeight - boundaryHeight, 0) * popoverWidth
      top: Math.max(popoverHeight - beyondOffset.top, 0) * popoverWidth + Math.max(popoverWidth - boundaryWidth, 0) * popoverHeight
      bottom: Math.max(popoverHeight - beyondOffset.bottom, 0) * popoverWidth + Math.max(popoverWidth - boundaryWidth, 0) * popoverHeight
    }

  _getDimensions: ($el) ->
    return {
      left: 0, right: 0, top: 0, bottom: 0
    } if $el[0] is window

    $window = $ window
    offset = $el.offset()

    {
      left: offset.left - $window.scrollLeft()
      right: $window.scrollLeft() + $window.width() - offset.left - $el.outerWidth()
      top: offset.top - $window.scrollTop()
      bottom: $window.scrollTop() + $window.height() - offset.top - $el.outerHeight()
    }

  toString: ->
    @directions.join('-')
