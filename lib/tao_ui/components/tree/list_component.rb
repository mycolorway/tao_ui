module TaoUi
  module Components
    module Tree
      class ListComponent < TaoOnRails::Components::Base

        attr_reader :items, :selectable, :depth, :remote,
                    :expanded, :children_key, :selected

        def initialize view, items, options = {}
          super view, options
          @items = items
          @children_key = @options.delete(:children_key)
          @selectable = @options.delete(:selectable)
          @selected = @options.delete(:selected)
          @remote = @options.delete(:remote)
          @expanded = @options.delete(:expanded)
          @depth = @options.delete(:depth)
        end

        def render &block
          view.content_tag 'div', html_options do
            if items && items.size > 0
              items.each do |item|
                view.concat view.tao_tree_item item, {
                  children_key: children_key,
                  selectable: selectable,
                  selected: selected,
                  depth: depth,
                  remote: remote,
                  expanded: expanded
                }, &block
              end
            end
          end
        end

        def self.component_name
          :tree_list
        end

        private

        def default_options
          {class: 'tao-tree-list', children_key: :children, depth: 0}
        end

      end
    end
  end
end
