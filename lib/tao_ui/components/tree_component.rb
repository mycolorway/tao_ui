module TaoUi
  module Components
    class TreeComponent < TaoOnRails::Components::Base

      attr_reader :items, :selectable, :children_key, :remote, :expanded

      def initialize view, items, options = {}
        super view,options
        @items = items
        @children_key = @options.delete(:children_key)
        @selectable = @options[:selectable] || false
        @remote = @options.delete(:remote)
        @expanded = @options.delete(:expanded)
      end

      def render &block
        view.content_tag tag_name, html_options do
          view.tao_tree_list items, {
            depth: 0,
            selectable: selectable,
            remote: remote,
            expanded: expanded,
            children_key: children_key
          }, &block
        end
      end

      def self.component_name
        :tree
      end

      private

      def default_options
        {class: 'tao-tree', children_key: :children}
      end

    end
  end
end
