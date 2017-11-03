import PopoverElement from './element'
import { Component } from '@mycolorway/tao'

class ConfirmPopoverElement extends PopoverElement

  @tag 'tao-confirm-popover'

  _connected: ->
    super()

    @on 'click', '.button-confirm', (e) =>
      @namespacedTrigger 'confirm'
      @active = false
      null

    @on 'click', '.button-cancel', (e) =>
      @namespacedTrigger 'cancel'
      @active = false
      null

  setContent: (content) ->
    @jq.find('.tao-popover-content .message').empty()
      .append content
    @

Component.register ConfirmPopoverElement

export default ConfirmPopoverElement
