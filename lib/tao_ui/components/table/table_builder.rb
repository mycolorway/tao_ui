module TaoUi
  module Components
    module Table

      class TableBuilder < BaseBuilder

        def head head_options = {}, &block
          head_content = view.capture(head_builder, &block)
          head_content = selectable_th + head_content if selectable
          head_content = expandable_th + head_content if expandable
          view.content_tag 'thead', head_options do
            view.content_tag 'tr', head_content
          end
        end

        def body body_options = {}, &block
          body_content = view.capture(body_builder, &block)
          view.content_tag 'tbody', body_content, body_options
        end

        private

        def head_builder
          @head_builder ||= HeadBuilder.new(view, options)
        end

        def body_builder
          @body_builder ||= BodyBuilder.new(view, options)
        end

      end

    end
  end
end
