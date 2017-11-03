import DialogElement from './element'
import { Component } from '@mycolorway/tao'

class MessageDialogElement extends DialogElement

  @tag 'tao-message-dialog'

  _bind: ->
    super()

    @on 'click', '.button-confirm', (e) =>
      @namespacedTrigger 'confirm'
      @active = false
      null

Component.register MessageDialogElement

export default MessageDialogElement
