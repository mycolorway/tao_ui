module Tao
  module Generators
    class IconsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      attr_reader :icons_html

      def create_icons_file
        @icons_html = svg_files.map {|file| "  #{symbol(file)}\n"}.join
        template 'icons.coffee.erb', File.join('lib/assets/javascripts/tao/ui/icons', "#{name.to_s}.coffee")
      end

      private

      def svg_files
        Dir.glob([
          File.expand_path('app/assets/icons/*.svg', destination_root),
          File.expand_path('lib/assets/icons/*.svg', destination_root)
        ]).uniq
      end

      def symbol(path)
        name = File.basename(path, ".*").underscore().dasherize()
        document = Nokogiri::XML(File.read(path))
        document.css('[id="Main"], [id="Main"] [fill], [fill="none"]').each {|n| n.delete 'fill' }
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
