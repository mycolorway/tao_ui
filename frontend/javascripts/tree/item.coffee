import { Component } from '@mycolorway/tao'
import $ from 'jquery'
import _ from 'lodash'

class ItemElement extends Component

  @tag 'tao-tree-item'

  @attribute 'depth', type: 'number'

  @attribute 'expandable', 'selectable', type: 'boolean'

  @attribute 'expanded', 'selected', 'indeterminate', type: 'boolean', observe: true

  @attribute 'remote', type: 'hash'

  _connected: ->
    @_initSelectable() if @selectable
    @_initExpandable() if @expandable

  _disconnected: ->
    @off()
    @checkbox?.off()
    @checkbox = null

  _initSelectable: ->
    @checkbox = @findComponent '> .tao-tree-item-content tao-check-box', =>
      @_selectedChanged() if @selected

    @checkbox.on 'tao:change', (e) =>
      @selected = e.currentTarget.checked
      @namespacedTrigger 'selectedChange', [@selected]
      null

  _initExpandable: ->
    @on 'click', '> .tao-tree-item-content > .link-toggle-item', (e) =>
      return if @jq.hasClass('expanding')
      @_toggleExpanded()
      null

  _beforeExpandedChanged: (expanded) ->
    $list = @jq.find('> .tao-tree-list')
    @jq.addClass 'expanding'
    $list.css 'display', 'block'
    $list.css 'height',  if expanded then '0' else $list.get(0).scrollHeight
    $list.one 'transitionend', => @_afterTransition()
    @reflow()
    null

  _expandedChanged: ->
    return unless @expandable
    $list = @jq.find('> .tao-tree-list')
    if @expanded
      $list.css 'height',  $list.get(0).scrollHeight
    else
      $list.css 'height', '0'

  _selectedChanged: ->
    return unless @selectable
    @checkbox.checked = @selected
    null

  _indeterminateChanged: ->
    return unless @selectable
    @checkbox.indeterminate = @indeterminate
    null

  _afterTransition: ->
    $list = @jq.find('> .tao-tree-list')
    @jq.removeClass 'expanding'
    if @expanded
      $list.css 'height', 'auto'
      if @remote && $list.find('> .tao-tree-loading').length > 0
        @_requestList()
    else
      $list.hide()

  _toggleExpanded: ->
    @expanded = !@expanded

  _requestList: ->
    $.ajax
      url: @remote.url
      type: 'get'
      data: _.extend {}, @remote.params,
        tree_item_id: @taoId
        depth: @depth
      dataType: 'script'

  updateList: ($newList) ->
    @_afterTransition() if @jq.hasClass('expanding')
    @jq.find('> .tao-tree-list').replaceWith($newList)
    @namespacedTrigger 'listUpdate', [$newList]

export default ItemElement.register()
