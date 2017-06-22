module TaoUi
  module Components
    class MessageDialogComponent < DialogComponent

      attr_reader :confirm_text

      def initialize view, options
        super view, options

        @confirm_text = @options[:confirm_text] || I18n.t('tao_ui.components.dialog.confirm')
      end

      def self.component_name
        :message_dialog
      end

      private

      def default_options
        {class: 'tao-dialog tao-message-dialog', with_close_button: false}
      end

    end
  end
end
