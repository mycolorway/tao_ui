import PopoverElement from './popover/element'

class TooltipElement extends PopoverElement

  @tag 'tao-tooltip'

TooltipElement.register()

export default { Element: TooltipElement }
export { TooltipElement as Element }
