import { Component } from '@mycolorway/tao'
import $ from 'jquery'
import _ from 'lodash'

class SortableElement extends Component

  @tag 'tao-sortable'

  @attribute 'groupSelector'

  @attribute 'itemSelector', default: '[draggable="true"]'

  @attribute 'itemHandleSelector'

  @attribute 'axis', default: 'y'

  _connected: ->
    handleSelector = if @itemHandleSelector
      "#{@itemSelector} #{@itemHandleSelector}"
    else
      @itemSelector

    @on 'dragstart', handleSelector, (e) =>
      e.stopPropagation()
      $item = $(e.currentTarget).closest(@itemSelector)
      itemRect = $item.get(0).getBoundingClientRect()
      @_startDragging $item

      e.originalEvent.dataTransfer.effectAllowed = 'move'
      e.originalEvent.dataTransfer.setData 'text/plain', 'tao-sortable'
      e.originalEvent.dataTransfer.setDragImage(
        @_sortingItem.get(0),
        e.clientX - itemRect.left,
        e.clientY - itemRect.top
      )
      null

  _disconnected: ->
    @off()
    $(document).off ".tao-sortable-#{@taoId}"

  _startDragging: ($item) ->
    @namespacedTrigger 'beforeSortStart', [$item]
    @_sortingItem = $item
    setTimeout -> $item.addClass('tao-sortable-sorting')
    @namespacedTrigger 'sortStart', [@_sortingItem]

    $(window).on "scroll.tao-sortable-#{@taoId}", _.throttle (e) =>
      @_expireDimensionCache()
      null
    , 100

    $(document).on "dragover.tao-sortable-#{@taoId}", _.throttle (e) =>
      e.preventDefault()
      @_performDragging x: e.clientX, y: e.clientY
      e.originalEvent.dataTransfer.dropEffect = 'move'
      null
    , 100

    $(document).on "dragend.tao-sortable-#{@taoId}", (e) =>
      e.preventDefault()
      @_stopDragging()
      $(document).off ".tao-sortable-#{@taoId}"
      $(window).off ".tao-sortable-#{@taoId}"
      null

  _performDragging: (mousePosition) ->
    return unless @_sortingItem
    item = @_findNearestItem mousePosition
    return unless item && item.el.get(0) != @_sortingItem.get(0)

    @_moveItem item, mousePosition
    @_expireDimensionCache()

  _stopDragging: ->
    @_sortingItem.removeClass('tao-sortable-sorting')
    @namespacedTrigger 'sortEnd', [@_sortingItem]
    @_sortingItem = null

  _findNearestItem: (mousePosition, dimensions = @_itemDimensions()) ->
    minDistance = null
    nearestItem = null

    dimensions.forEach (item) =>
      distance = @_getDistanceFromItem item, mousePosition
      if _.isNil(minDistance) || minDistance > distance
        minDistance = distance
        nearestItem = item

    if nearestItem.type == 'group' && nearestItem.items &&
        nearestItem.items.length > 0
      nearestItem = @_findNearestItem mousePosition, nearestItem.items

    nearestItem

  _moveItem: (item, mousePosition) ->
    if item.type == 'group'
      return if @triggerHandler('tao:sorting', [@_sortingItem, item]) == false
      item.el.append @_sortingItem
    else
      method = if (@axis == 'y' && mousePosition.y > item.center.y) ||
          (@axis == 'x' && mousePosition.x > item.center.x)
        'after'
      else
        'before'
      return if @triggerHandler('tao:sorting', [@_sortingItem, item, method]) == false
      item.el[method] @_sortingItem

  _itemDimensions: ->
    @_dimentions ||= do =>
      if @groupSelector
        @jq.find(@groupSelector).map (i, groupEl) =>
          @_getGroupDimension groupEl
        .get()
      else
        @jq.find(@itemSelector).map (i, itemEl) =>
          @_getItemDimension itemEl
        .get()

  _getGroupDimension: (groupEl) ->
    $group = $ groupEl
    dimension = $group.get(0).getBoundingClientRect()

    type: 'group'
    el: $group
    dimension: dimension
    center: @_getCenterPointOfDimension(dimension)
    items: $group.find(@itemSelector).map (i, itemEl) =>
      @_getItemDimension itemEl
    .get()

  _getItemDimension: (itemEl) ->
    $item = $ itemEl
    dimension = $item.get(0).getBoundingClientRect()

    type: 'item'
    el: $item
    dimension: dimension
    center: @_getCenterPointOfDimension(dimension)

  _getCenterPointOfDimension: (dimension) ->
    x: dimension.left + (dimension.width / 2)
    y: dimension.top + (dimension.height / 2)

  _getDistanceFromItem: (item, position) ->
    rect = item.dimension
    if position.x >= rect.left && position.x <= rect.right &&
        position.y >= rect.top && position.y <= rect.bottom
      0
    else
      deltaX = Math.min(Math.abs(position.x - rect.left), Math.abs(position.x - rect.right))
      deltaY = Math.min(Math.abs(position.y - rect.top), Math.abs(position.y - rect.bottom))
      Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2))

  _expireDimensionCache: ->
    @_dimentions = null

SortableElement.register()

export default { Element: SortableElement }
export { SortableElement as Element }
