module TaoUi
  module Components
    class TooltipComponent < TaoOnRails::Components::Base

      def self.component_name
        :tooltip
      end

      def self.template_name
        @template_name ||= :popover
      end

      private

      def default_options
        {class: 'tao-tooltip', auto_hide: true, with_arrow: true, trigger_action: :hover}
      end

    end
  end
end
