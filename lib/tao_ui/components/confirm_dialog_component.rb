module TaoUi
  module Components
    class ConfirmDialogComponent < MessageDialogComponent

      attr_reader :cancel_text

      def initialize view, options
        super view, options
        @cancel_text = @options[:cancel_text] || I18n.t('tao_ui.components.dialog.cancel')
      end

      def self.component_name
        :confirm_dialog
      end

      private

      def default_options
        {class: 'tao-dialog tao-confirm-dialog', with_close_button: false}
      end

    end
  end
end
