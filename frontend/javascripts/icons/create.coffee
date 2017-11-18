import _ from 'lodash'

create = (name, attrs = {}) ->
  name = _.kebabCase name
  $("<svg><use xlink:href=\"#icon-#{name}\"/></svg>")
    .attr attrs
    .addClass "icon icon-#{name}"

export default create
