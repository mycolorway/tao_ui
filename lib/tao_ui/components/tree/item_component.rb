module TaoUi
  module Components
    module Tree
      class ItemComponent < TaoOnRails::Components::Base

        attr_reader :item, :selectable, :depth, :remote,
                    :expandable, :expanded, :children, :children_key

        def initialize view, item, options = {}
          super view, options
          @item = item
          @children_key = @options.delete(:children_key)
          @selectable = @options[:selectable] || false
          @depth = @options[:depth]

          init_remote
          init_children
          init_expanded
        end

        def render &block
          view.content_tag tag_name, html_options do
            content = view.content_tag 'div', class: 'tao-tree-item-content' do
              render_padding + render_icon +
                render_checkbox + view.capture(item, self, &block)
            end

            children = render_children &block
            content + children
          end
        end

        def self.component_name
          :tree_item
        end

        private

        def default_options
          {class: 'tao-tree-item', children_key: :children, depth: 0}
        end

        def init_children
          @children = if item.is_a?(Hash)
            item[children_key]
          elsif item.respond_to?(children_key)
            item.send(children_key)
          else
            nil
          end
        end

        def init_remote
          @remote = html_options.delete(:remote) || false
          @remote = @remote.call(item, depth) if @remote.respond_to?(:call)
          if @remote && @remote.is_a?(Hash)
            html_options[:remote] = @remote.to_json
          end
        end

        def init_expanded
          @expandable = !!remote || children.try(:any?)
          html_options[:expandable] = @expandable ? '' : nil

          @expanded = (html_options.delete(:expanded) || false) && expandable && !remote
          @expanded = @expanded.call(item, depth) if @expanded.respond_to?(:call)
          html_options[:expanded] = @expanded ? '' : nil
        end

        def render_padding(size = depth)
          view.content_tag 'div', class: 'tao-tree-item-padding' do
            (view.content_tag('div', nil, class: 'padding-item') * (size + 1)).html_safe
          end
        end

        def render_icon
          view.link_to 'javascript:;', class: 'link-toggle-item' do
            view.tao_icon :arrow_right
          end
        end

        def render_checkbox
          if @selectable
            view.tao_check_box
          else
            ''.html_safe
          end
        end

        def render_children &block
          if remote
            render_children_placeholder
          else
            view.tao_tree_list children, {
              selectable: selectable,
              depth: depth + 1,
              remote: options[:remote],
              expanded: options[:expanded],
              children_key: @children_key
            }, &block
          end
        end

        def render_children_placeholder
          view.content_tag 'div', class: 'tao-tree-list' do
            view.content_tag 'div', class: 'tao-tree-loading tao-tree-item' do
              view.content_tag 'div', class: 'tao-tree-item-content' do
                render_padding(depth + 1) + view.tao_icon(:loading, class: 'spin') + t(:loading)
              end
            end
          end
        end

      end
    end
  end
end
