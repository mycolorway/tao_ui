import { Component } from '@mycolorway/tao'
import Selectable from './selectable'
import Expandable from './expandable'

class TableElement extends Component

  @tag 'tao-table'

  @include Selectable

  @include Expandable

  _connected: ->
    @_initSelectable()
    @_initExpandable()

Component.register TableElement

export default TableElement
