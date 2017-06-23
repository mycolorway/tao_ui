module TaoUi
  module Components
    class PopoverComponent < TaoOnRails::Components::Base

      def self.component_name
        :popover
      end

      private

      def default_options
        {class: 'tao-popover', auto_hide: true, with_arrow: true}
      end

    end
  end
end
