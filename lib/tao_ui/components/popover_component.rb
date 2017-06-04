module TaoUi
  module Components
    class PopoverComponent < TaoOnRails::Components::Base

      def self.component_name
        :popover
      end

      private

      def default_options
        {class: 'tao-popover'}
      end

    end
  end
end
