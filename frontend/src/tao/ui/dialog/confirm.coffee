import { Component } from '@mycolorway/tao'
import MessageDialogElement from './message'

class ConfirmDialogElement extends MessageDialogElement

  @tag 'tao-confirm-dialog'

  _bind: ->
    super()

    @on 'click', '.button-cancel', (e) =>
      @namespacedTrigger 'cancel'
      @active = false
      null

Component.register ConfirmDialogElement

export default ConfirmDialogElement
