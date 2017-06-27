module TaoUi
  module Components
    class TableComponent < TaoOnRails::Components::Base

      def render &block
        if block_given?
          table = view.content_tag('table', class: 'table', &block)
          view.content_tag tag_name, table, html_options
        else
          super
        end
      end

      def self.component_name
        :table
      end

      private

      def default_options
        {class: 'tao-table'}
      end

    end
  end
end
