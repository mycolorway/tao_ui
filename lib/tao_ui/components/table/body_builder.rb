module TaoUi
  module Components
    module Table

      class BodyBuilder < BaseBuilder

        def row row_options = {}, &block
          row_content = view.capture(row_builder, &block)
          row_builder.reset

          if expandable
            row_content
          else
            row_content = selectable_td + row_content if selectable
            row_content = expandable_td + row_content if expandable
            view.content_tag 'tr', row_content, row_options
          end
        end

        private

        def row_builder
          @row_builder ||= RowBuilder.new(view, options)
        end

      end

    end
  end
end
