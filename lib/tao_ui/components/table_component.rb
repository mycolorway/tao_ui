module TaoUi
  module Components
    class TableComponent < TaoOnRails::Components::Base

      def render &block
        if block_given?
          table_content = view.capture(builder, &block)
          table = view.content_tag('table', table_content, class: 'table')
          view.content_tag tag_name, table, html_options
        else
          super
        end
      end

      def self.component_name
        :table
      end

      private

      def builder
        @builder ||= Table::TableBuilder.new(view, {
          expandable: options[:expandable],
          selectable: options[:selectable]
        })
      end

      def default_options
        {class: 'tao-table'}
      end

    end
  end
end
