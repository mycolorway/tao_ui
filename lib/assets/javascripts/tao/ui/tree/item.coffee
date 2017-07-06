
class Tao.Tree.Item extends TaoComponent

  @tag 'tao-tree-item'

  @attribute 'depth', type: 'number'

  @attribute 'expandable', 'selectable', type: 'boolean'

  @attribute 'expanded', type: 'boolean', observe: true

  @attribute 'remote', type: 'hash'

  _connected: ->
    @_bind()

  _bind: ->
    @on 'click', '> .tao-tree-item-content > .link-toggle-item', (e) =>
      @_toggleExpanded() if @expandable
      null

  _beforeExpandedChanged: (expanded) ->
    $list = @jq.find('> .tao-tree-list')
    $list.addClass 'expanding'
    $list.css 'display', 'block'
    $list.css 'height',  if expanded then '0' else $list.get(0).scrollHeight
    @reflow()

    $list.one 'transitionend', ->
      $list.removeClass 'expanding'
      if expanded
        $list.css 'height', 'auto'
      else
        $list.hide()

  _expandedChanged: ->
    $list = @jq.find('> .tao-tree-list')
    if @expanded
      $list.css 'height',  $list.get(0).scrollHeight
      if @remote && $list.find('> .tao-tree-loading').length > 0
        @_requestList()
    else
      $list.css 'height', '0'

  _toggleExpanded: ->
    @expanded = !@expanded

  _requestList: ->
    $.ajax
      url: @remote.url
      type: 'get'
      data: @remote.params
      dataType: 'script'


TaoComponent.register Tao.Tree.Item
