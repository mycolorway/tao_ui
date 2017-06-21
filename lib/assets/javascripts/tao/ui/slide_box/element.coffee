#= require tao/ui/shared/slide_box/element/base

class Tao.SlideBox.Element extends Tao.SlideBox.ElementBase

  @attribute 'withCloseButton', type: 'boolean'

  _autoHideEvent: 'mousedown'

TaoComponent.register Tao.SlideBox.Element
