require 'autoprefixer-rails'
require 'tao_on_rails'
require 'tao_ui/components'
require 'tao_ui/action_view/helpers'

module TaoUi
  class Engine < ::Rails::Engine

    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}')]
    paths['app/views'] << 'lib/views'

    initializer "tao_on_rails.view_helpers" do |app|
      ::ActiveSupport.on_load :action_view do
        include TaoUi::ActionView::Helpers
      end
    end

  end
end
