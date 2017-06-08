# hack ujs for adding loading icon on disabled buttons/links

prependLoadingIcon = (element) ->
  $(element).prepend Tao.ui.iconTag('loading', class: 'spin')

# jquery-ujs
if $.rails?
  originDisableElement = $.rails.disableElement
  $.rails.disableElement = (element) ->
    originDisableElement element
    prependLoadingIcon element

  originDisableFormElement = $.rails.disableFormElement
  $.rails.disableFormElement = (element) ->
    originDisableFormElement element
    prependLoadingIcon element

# rails-ujs
else if Rails?
  originDisableElement = Rails.disableElement
  Rails.disableElement = (e) ->
    originDisableElement e
    element = if e instanceof Event then e.target else e
    if Rails.matches(element, Rails.formSubmitSelector)
      Rails.formElements(element, Rails.formDisableSelector).forEach (el) ->
        prependLoadingIcon el
    else
      prependLoadingIcon element
