import $ from 'jquery'
import Rails from 'rails-ujs'
import createIcon from '../icons/create'


# hack ujs for adding loading icon on disabled buttons/links
originDisableElement = Rails.disableElement
Rails.disableElement = (e) ->
  originDisableElement e
  element = if e instanceof Event then e.target else e
  if Rails.matches(element, Rails.formSubmitSelector)
    Rails.formElements(element, Rails.formDisableSelector).forEach (el) ->
      prependLoadingIcon el
  else
    prependLoadingIcon element

originEnableElement = Rails.enableElement
Rails.enableElement = (e) ->
  originEnableElement e
  element = if e instanceof Event then e.target else e
  if Rails.matches(element, Rails.formSubmitSelector)
    Rails.formElements(element, Rails.formDisableSelector).forEach (el) ->
      $(el).removeClass 'text-with-icon'
  else
    $(el).removeClass 'text-with-icon'

prependLoadingIcon = (element) ->
  $element = $ element
  if $element.is('button') && $element.data('loading')
    $element.addClass('text-with-icon')
      .prepend createIcon('loading', class: 'spin')
