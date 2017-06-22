module TaoUi
  module Components
    class ConfirmPopoverComponent < PopoverComponent

      attr_reader :confirm_text, :cancel_text

      def initialize view, options
        super view, options
        @confirm_text = @options[:confirm_text] || I18n.t('tao_ui.components.dialog.confirm')
        @cancel_text = @options[:cancel_text] || I18n.t('tao_ui.components.dialog.cancel')
      end

      def self.component_name
        :confirm_popover
      end

      private

      def default_options
        merge_options super, {class: 'tao-confirm-popover'}
      end

    end
  end
end
