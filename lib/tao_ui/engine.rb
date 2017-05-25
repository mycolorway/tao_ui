require 'tao_on_rails'
require 'tao_ui/components'

module TaoUi
  class Engine < ::Rails::Engine

    paths['app/views'] << 'lib/views'

  end
end
