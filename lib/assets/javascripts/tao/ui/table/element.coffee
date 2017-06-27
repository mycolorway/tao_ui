class Tao.Table.Element extends TaoComponent

  @tag 'tao-table'

  @include Tao.Table.Selectable

  @include Tao.Table.Expandable

  _connected: ->
    @_initSelectable()
    @_initExpandable()

TaoComponent.register Tao.Table.Element
