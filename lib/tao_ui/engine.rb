require 'tao_on_rails'
require 'tao_ui/components'

module TaoUi
  class Engine < ::Rails::Engine

    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}')]
    paths['app/views'] << 'lib/views'

  end
end
