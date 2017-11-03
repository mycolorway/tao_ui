# import all icons
req = require.context('../../../../icons', true, /\.svg$/)
req.keys().forEach(req)

export default {
  create: (name, attrs = {}) ->
    $("<svg><use xlink:href=\"#icon-#{name}\"/></svg>")
      .attr attrs
      .addClass "icon icon-#{name}"
}
