# hack ujs for adding loading icon on disabled buttons/links

prependLoadingIcon = (element) ->
  $(element).addClass('text-with-icon')
    .prepend Tao.iconTag('loading', class: 'spin')

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

  originEnableElement = $.rails.enableElement
  $.rails.enableElement = (element) ->
    originEnableElement element
    $(element).removeClass 'text-with-icon'

  originEnableFormElement = $.rails.enableFormElement
  $.rails.enableFormElement = (element) ->
    originEnableFormElement element
    $(element).removeClass 'text-with-icon'

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

  originEnableElement = Rails.enableElement
  Rails.enableElement = (e) ->
    originEnableElement e
    element = if e instanceof Event then e.target else e
    if Rails.matches(element, Rails.formSubmitSelector)
      Rails.formElements(element, Rails.formDisableSelector).forEach (el) ->
        $(el).removeClass 'text-with-icon'
    else
      $(el).removeClass 'text-with-icon'
