module Tao
  module Generators
    class IconsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      class_option :paths, type: :array, default: ['app/assets/icons', 'lib/assets/icons'], desc: 'Find svg files in specified paths.'

      class_option :remove_color, type: :boolean, default: false, desc: 'Remove all fill attributes in svg.'

      attr_reader :icons_html

      def create_icons_file
        @icons_html = svg_files.map {|file| "  #{symbol(file)}\n"}.join
        template 'icons.coffee.erb', File.join('lib/assets/javascripts/tao/ui/icons', "#{name.to_s}.coffee")
      end

      private

      def svg_files
        Dir.glob(options[:paths].map { |p|
          File.expand_path(File.join(p, '*.svg'), destination_root)
        }).uniq
      end

      def symbol(path)
        name = File.basename(path, ".*").underscore().dasherize()
        document = Nokogiri::XML(File.read(path))

        if options[:remove_color] && !name.include?('with-color')
          document.css('[fill]').each {|n| n.delete 'fill' }
        else
          document.css('[id="Main"], [id="main"], [fill="none"]')
            .each {|n| n.delete 'fill' }
        end

        content = document.to_s
        content.gsub(/<?.+\?>/,'')
          .gsub(/<!.+?>/,'')
          .gsub(/<title>.*<\/title>/, '')
          .gsub(/<desc>.*<\/desc>/, '')
          .gsub(/id=/,'class=')
          .gsub(/<svg.+?>/, %Q{<svg id="icon-#{name}" #{dimensions(content)}>})
          .gsub(/svg/,'symbol')
          .gsub(/\n/, '') # Remove endlines
          .gsub(/\s{2,}/, ' ') # Remove whitespace
          .gsub(/>\s+</, '><') # Remove whitespace between tags
      end

      def dimensions(content)
        dimension = content.scan(/<svg.+(viewBox=["'](.+?)["'])/).flatten
        %Q{#{dimension.first} width="100%" height="100%"}
      end

    end
  end
end
