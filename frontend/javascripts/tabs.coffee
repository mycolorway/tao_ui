import { Component } from '@mycolorway/tao'

class Tabs extends Component

  @tag 'tao-tabs'

  _connected: ->
    @on 'click', '.tabs > .tab', (e) =>
      e.preventDefault()
      $tab = $(e.currentTarget)
      @_activateTab $tab

  _disconnected: ->
    @off()

  _activateTab: ($tab) ->
    $panel = @jq.find($tab.attr('href'))
    @_toggleItemActive $tab, '.tab'
    @_toggleItemActive $panel, '.panel'

  _toggleItemActive: ($item, itemSelector = '*') ->
    $item.addClass('active')
      .siblings(itemSelector)
      .removeClass('active')

export default Tabs.register()
