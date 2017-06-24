require 'test_helper'
require 'generators/tao/icons/icons_generator'

class Tao::Generators::IconsGeneratorTest < Rails::Generators::TestCase

  tests Tao::Generators::IconsGenerator
  destination File.expand_path("tmp", File.dirname(__FILE__))

  setup do
  end

  teardown do
    FileUtils.rm_rf(destination_root)
  end

  test 'generate icons file' do
    prepare_icon 'home'
    assert_no_file 'lib/assets/javascripts/tao/ui/icons/base.coffee'
    run_generator %w(base --remove_color)
    assert_file 'lib/assets/javascripts/tao/ui/icons/base.coffee' do |content|
      assert_match(/Tao._icons \+=/, content)
      assert_match(/<symbol id="icon-home"/, content)
      assert_no_match(/fill/, content)
    end
  end

  test 'generate icons file with color' do
    prepare_icon 'home_with_color'
    assert_no_file 'lib/assets/javascripts/tao/ui/icons/base.coffee'
    run_generator %w(base --remove_color)
    assert_file 'lib/assets/javascripts/tao/ui/icons/base.coffee' do |content|
      assert_match(/Tao._icons \+=/, content)
      assert_match(/<symbol id="icon-home-with-color"/, content)
      assert_match(/fill/, content)
    end
  end

  private

  def prepare_icon icon_name
    copy_from = File.expand_path("icons/#{icon_name}.svg", File.dirname(__FILE__))
    copy_to = File.expand_path('app/assets/icons', destination_root)
    FileUtils.mkdir_p copy_to
    FileUtils.cp copy_from, copy_to
  end

end
