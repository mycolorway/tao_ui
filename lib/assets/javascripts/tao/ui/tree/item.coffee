class Tao.Tree.Item extends TaoComponent

  @tag 'tao-tree-item'

  @attribute 'depth', type: 'number'

  @attribute 'expandable', 'selectable', type: 'boolean'

  @attribute 'expanded', 'selected', 'indeterminate', type: 'boolean', observe: true

  @attribute 'remote', type: 'hash'

  _connected: ->
    @checkbox = @findComponent '> .tao-tree-item-content tao-check-box', =>
      @_selectedChanged() if @selected
    @_bind()

  _disconnected: ->
    @off()
    @checkbox.off()
    @checkbox = null

  _bind: ->
    @on 'click', '> .tao-tree-item-content > .link-toggle-item', (e) =>
      @_toggleExpanded() if @expandable && !@jq.hasClass('expanding')
      null

    @checkbox.on 'tao:change', (e) =>
      @selected = e.currentTarget.checked
      @trigger 'tao-tree-item:selectedChange', [@selected]
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
        depth: @depth
        selectable: @selectable || undefined
        selected: @selected || undefined
      dataType: 'script'

  updateList: ($newList) ->
    @_afterTransition() if @jq.hasClass('expanding')
    @jq.find('> .tao-tree-list').replaceWith($newList)

TaoComponent.register Tao.Tree.Item
