require 'test_helper'
require 'generators/tao/icons/icons_generator'

class Tao::Generators::IconsGeneratorTest < Rails::Generators::TestCase

  tests Tao::Generators::IconsGenerator
  destination File.expand_path("tmp", File.dirname(__FILE__))

  setup do
    copy_from = File.expand_path('icons/Zhiren.svg', File.dirname(__FILE__))
    copy_to = File.expand_path('app/assets/icons', destination_root)
    FileUtils.mkdir_p copy_to
    FileUtils.cp copy_from, copy_to
  end

  teardown do
    FileUtils.rm_rf(destination_root)
  end

  test 'generate icons file' do
    assert_no_file 'lib/assets/javascripts/tao/ui/icons/basic.coffee'
    run_generator %w(basic)
    assert_file 'lib/assets/javascripts/tao/ui/icons/basic.coffee' do |content|
      assert_match(/Tao.icons.html \+=/, content)
      assert_match(/<symbol id="icon-zhiren"/, content)
    end
  end

end
