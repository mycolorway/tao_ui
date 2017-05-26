module TaoUi
  module Components
    class PopoverComponent < TaoOnRails::Components::Base

      def initialize view, options = {}
        super

        if html_options[:class].present?
          html_options[:class] += ' tao-popover'
        else
          html_options[:class] = 'tao-popover'
        end
      end

      def self.component_name
        :popover
      end

    end
  end
end
