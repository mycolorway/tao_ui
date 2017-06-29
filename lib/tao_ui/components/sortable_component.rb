module TaoUi
  module Components
    class SortableComponent < TaoOnRails::Components::Base

      def self.component_name
        :sortable
      end

      private

      def default_options
        {class: 'tao-sortable'}
      end

    end
  end
end
