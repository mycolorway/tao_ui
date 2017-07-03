module TaoUi
  module Components
    module Table

      class HeadBuilder < BaseBuilder

        def cell content_or_options = nil, cell_options = nil, &block
          view.content_tag 'th', content_or_options, cell_options, &block
        end

      end

    end
  end
end
