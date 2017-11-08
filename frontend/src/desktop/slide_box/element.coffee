import SlideBoxElementBase from '../../shared/slide_box/element'

class SlideBoxElement extends SlideBoxElementBase

  @attribute 'withCloseButton', type: 'boolean'

  _autoHideEvent: 'mousedown'

export default SlideBoxElement.register()
