module TaoUi
  module ActionView
    module Helpers

      def tao_table_builder options = {}
        TaoUi::Components::Table::TableBuilder.new self, options
      end

      def tao_table_head_builder options = {}
        TaoUi::Components::Table::HeadBuilder.new self, options
      end

      def tao_table_body_builder options = {}
        TaoUi::Components::Table::BodyBuilder.new self, options
      end

      def tao_table_row_builder options = {}
        TaoUi::Components::Table::RowBuilder.new self, options
      end

    end
  end
end
