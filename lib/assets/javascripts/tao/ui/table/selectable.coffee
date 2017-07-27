Tao.Table.Selectable = ->

  @attribute 'selectable', type: 'boolean'

  @get 'selectedRows', ->
    @jq.find('tbody > tr.selected')

  _initSelectable: ->
    @on 'tao:change', '.td-checkbox tao-check-box', (e) =>
      cb = e.currentTarget
      $row = cb.jq.closest('tr')
      @toggleSelectRow $row, cb.checked
      @namespacedTrigger 'selectedChange', [@selectedRows]

    @on 'tao:change', '.th-checkbox tao-check-box', (e) =>
      cb = e.currentTarget
      if cb.checked
        @selectAllRows()
      else
        @unselectAllRows()
      @namespacedTrigger 'selectedChange', [@selectedRows]

  toggleSelectRow: (row, selected) ->
    return @ unless @selectable

    $row = $ row
    currentSelected = $row.hasClass('selected')
    selected = !currentSelected if _.isNil selected
    if $row.is('.disabled, .hidden, .expandable-panel')\
        || selected == currentSelected
      return @

    $row.toggleClass 'selected', selected
    cb = $row.find('.td-checkbox tao-check-box').get(0)
    cb.checked = selected if cb.checked != selected
    @

  selectRow: (row) ->
    @toggleSelectRow row, true

  unselectRow: (row) ->
    @toggleSelectRow row, false

  selectAllRows: ->
    return @ unless @selectable
    @jq.find('tbody > tr').each (i, row) => @selectRow(row)
    @

  unselectAllRows: ->
    return @ unless @selectable
    @jq.find('tbody > tr').each (i, row) => @unselectRow(row)
    @
