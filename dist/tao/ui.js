(function() {
  window.Tao || (window.Tao = {});

}).call(this);
(function() {
  Tao.ui = {
    icons: '',
    iconTag: function(name, attributes) {
      if (attributes == null) {
        attributes = {};
      }
      return $("<svg><use xlink:href=\"#icon-" + name + "\"/></svg>").attr(attributes).addClass("icon icon-" + name);
    }
  };

  Tao.Application.initializer('icons', function(app) {
    return app.on('page-load', function(page) {
      if ($('#tao-icons').length > 0) {
        return;
      }
      return document.body.insertAdjacentHTML('afterbegin', "<svg id=\"tao-icons\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" style=\"display:none\">\n  " + Tao.ui.icons + "\n</svg>");
    });
  });

}).call(this);
(function() {
  Tao.ui.icons += '<symbol id="icon-loading" viewBox="0 0 20 20" width="100%" height="100%"><defs/><g class="zhiren_icon" stroke="none" stroke-width="1" fill-rule="evenodd"><g class="Main"><rect class="Path" opacity="0.5" x="9" y="0" width="2" height="6" rx="1"/><rect class="Path" opacity="0.600000024" transform="translate(14.828427, 4.828427) rotate(45.000000) translate(-14.828427, -4.828427) " x="13.8284271" y="1.82842712" width="2" height="6" rx="1"/><rect class="Path" opacity="0.400000006" transform="translate(4.828427, 4.828427) scale(-1, 1) rotate(45.000000) translate(-4.828427, -4.828427) " x="3.82842712" y="1.82842712" width="2" height="6" rx="1"/><rect class="Path" opacity="0.200000003" transform="translate(4.828427, 14.828427) rotate(45.000000) translate(-4.828427, -14.828427) " x="3.82842712" y="11.8284271" width="2" height="6" rx="1"/><rect class="Rectangle-24" opacity="0.300000012" x="0" y="9" width="6" height="2" rx="1"/><rect class="Rectangle-24" opacity="0.699999988" x="14" y="9" width="6" height="2" rx="1"/><rect class="Rectangle-24" opacity="0.05" transform="translate(14.828427, 14.828427) rotate(45.000000) translate(-14.828427, -14.828427) " x="11.8284271" y="13.8284271" width="6" height="2" rx="1"/><rect class="Combined-Shape" opacity="0.100000001" x="9" y="14" width="2" height="6" rx="1"/></g></g></symbol>\n';

}).call(this);
