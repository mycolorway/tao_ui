require 'tao_on_rails/components/base'

module TaoUi
  module Components
    class IconComponent < TaoOnRails::Components::Base

      attr_reader :name

      def initialize view, name, options = {}
        super view, options

        @name = name.to_s.dasherize

        if @options[:class].present?
          @options[:class] += " icon icon-#{name}"
        else
          @options[:class] = "icon icon-#{name}"
        end
      end

      def render
        view.content_tag(:svg, %Q(<use xlink:href="#icon-#{name}"/>).html_safe, options)
      end

      def self.component_name
        :icon
      end

    end
  end
end
