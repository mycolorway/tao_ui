import BrowserSprite from 'svg-baker-runtime/browser-sprite'
import { Application } from '@mycolorway/tao'
import $ from 'jquery'

spriteNodeId = 'tao-icons'
spriteGlobalVarName = '__TAO_SVG_SPRITE__'

if window[spriteGlobalVarName]
  sprite = window[spriteGlobalVarName]
else
  sprite = new BrowserSprite
    attrs:
      id: spriteNodeId
  window[spriteGlobalVarName] = sprite

Application.initializer 'icons', (app) ->
  app.on 'page-load', (e, page) ->
    existing = document.getElementById(spriteNodeId)
    if existing
      sprite.attach(existing)
    else
      sprite.node ||= sprite.render()
      $(document.body).prepend(sprite.node)

  app.on 'before-page-cache', (e, page) ->
    sprite.unmount() if sprite.node.parentNode

export default sprite
