require 'autoprefixer-rails'
require 'tao_on_rails'

module TaoUi
  class Engine < ::Rails::Engine

    config.eager_load_paths += Dir["#{config.root}/lib"]

    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}')]

    paths['app/views'] << 'lib/views'

    ::ActiveSupport.on_load :tao_components do
      load_tao_components TaoUi::Engine.root
    end

    initializer "tao_ui" do
      ::ActiveSupport.on_load :action_view do
        include TaoUi::ActionView::Helpers
      end
    end

  end
end
