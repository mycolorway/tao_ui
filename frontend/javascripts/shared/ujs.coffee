import $ from 'jquery'
import createIcon from '../icons/create'


# hack ujs for adding loading icon on disabled buttons/links
originDisableElement = $.rails.disableElement
$.rails.disableElement = (element) ->
  originDisableElement element
  prependLoadingIcon element

originDisableFormElement = $.rails.disableFormElement
$.rails.disableFormElement = (element) ->
  originDisableFormElement element
  prependLoadingIcon element

originEnableElement = $.rails.enableElement
$.rails.enableElement = (element) ->
  originEnableElement element
  $(element).removeClass 'text-with-icon'

originEnableFormElement = $.rails.enableFormElement
$.rails.enableFormElement = (element) ->
  originEnableFormElement element
  $(element).removeClass 'text-with-icon'

prependLoadingIcon = (element) ->
  $element = $ element
  if $element.is('button') && $element.data('loading')
    $element.addClass('text-with-icon')
      .prepend createIcon('loading', class: 'spin')
