import BrowserSprite from 'svg-baker-runtime/src/browser-sprite'

spriteNodeId = 'tao-icons'
spriteGlobalVarName = '__TAO_SVG_SPRITE__'

if window[spriteGlobalVarName]
  sprite = window[spriteGlobalVarName]
else
  sprite = new BrowserSprite
    attrs:
      id: spriteNodeId
  window[spriteGlobalVarName] = sprite

Tao.Application.initializer 'icons', (app) ->
  app.on 'page-load', (page) ->
    existing = document.getElementById(spriteNodeId)
    if existing
      sprite.attach(existing)
    else
      sprite.mount(document.body, true)

  app.on 'before-page-cache', (page) ->
    sprite.unmount()

export default sprite
