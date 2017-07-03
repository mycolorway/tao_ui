module TaoUi
  module Components
    module Table

      class RowBuilder < BaseBuilder

        def initialize view, options = {}
          super
          reset_cell_count
        end

        def cell content_or_options = nil, cell_options = nil, &block
          @cell_count += 1
          view.content_tag 'td', content_or_options, cell_options, &block
        end

        def content content_options = {}, &block
          raise 'content method requires expandable option set to true' unless expandable
          content_options = merge_options({
            class: 'expandable'
          }, content_options)
          row_content = view.capture(self, &block)
          row_content = selectable_td + row_content if selectable
          row_content = expandable_td + row_content if expandable
          view.content_tag 'tr', row_content, content_options
        end

        def panel panel_options = {}, &block
          raise 'panel method requires expandable option set to true' unless expandable
          view.content_tag 'tr', class: 'expandable-panel' do
            view.content_tag 'td', colspan: @cell_count do
              view.content_tag 'div', panel_options, &block
            end
          end
        end

        def reset_cell_count
          @cell_count = 0
          @cell_count += 1 if selectable
          @cell_count += 1 if expandable
        end

        private

        def row_builder
          @row_builder ||= RowBuilder.new(view)
        end

      end

    end
  end
end
