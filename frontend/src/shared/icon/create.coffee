create = (name, attrs = {}) ->
  $("<svg><use xlink:href=\"#icon-#{name}\"/></svg>")
    .attr attrs
    .addClass "icon icon-#{name}"

export default create
