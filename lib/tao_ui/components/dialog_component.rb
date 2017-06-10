module TaoUi
  module Components
    class DialogComponent < TaoOnRails::Components::Base

      def initialize view, options
        super

        unless @options[:with_close_button].in? [true, false]
          @options[:with_close_button] = true
        end
      end

      def self.component_name
        :dialog
      end

      private

      def default_options
        {class: 'tao-dialog'}
      end

    end
  end
end
