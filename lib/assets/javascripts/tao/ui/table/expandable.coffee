Tao.Table.Expandable = ->

  @attribute 'expandable', type: 'boolean'

  _initExpandable: ->
    @on 'click', 'tbody > tr.expandable', (e) =>
      return if !@expandable || $(e.target).is('a, input')
      $row = $ e.currentTarget
      if $row.hasClass 'expanded'
        @collapseRow $row
        @namespacedTrigger 'expandRow', $row
      else
        @expandRow $row
        @namespacedTrigger 'collapseRow', $row
      null

  expandRow: (row) ->
    $row = $ row
    return @ if $row.is('.disabled, .hidden, .expanded, .expanding')

    $panel = $row.next('.expandable-panel')
    return @ unless $panel.length > 0
    $panelWrapper = $panel.find('> td > div:first')

    $panel.show()
    $panel[0].offsetHeight # force reflow
    $panelWrapper.one 'transitionend', (e) ->
      $row.removeClass 'expanding'

    $row.addClass 'expanded expanding'
    $panel.addClass 'expanded'
    $panelWrapper.css 'height', $panelWrapper[0].scrollHeight
    @_loadRemotePanel $panel.find('> [data-url]')
    @

  collapseRow: (row) ->
    $row = $ row
    return @ if $row.is('.disabled, .hidden, :not(.expanded), .collapsing')

    $panel = $row.next('.expandable-panel')
    return @ unless $panel.length > 0
    $panelWrapper = $panel.find('> td > div:first')

    $panelWrapper.one 'transitionend', (e) ->
      $row.removeClass 'collapsing'
      $panel.hide()

    $row.removeClass 'expanded'
      .addClass 'collapsing'
    $panel.removeClass 'expanded'
    $panelWrapper.css 'height', 0
    @

  _loadRemotePanel: ($panel) ->
    return unless $panel.is('[data-url]')
    $.ajax
      url: $panel.data('url')
      method: 'get'
      dataType: 'script'
    .done ->
      $panel.removeAttr 'data-url'
