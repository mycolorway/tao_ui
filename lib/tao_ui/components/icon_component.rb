module TaoUi
  module Components
    class IconComponent < TaoOnRails::Components::Base

      attr_reader :name

      def initialize view, name, options = {}
        @name = name.to_s.dasherize
        super view, options
      end

      def render
        view.content_tag(:svg, %Q(<use xlink:href="#icon-#{name}"/>).html_safe, options)
      end

      def self.component_name
        :icon
      end

      private

      def default_options
        {class: ['icon', "icon-#{@name}"]}
      end

    end
  end
end
