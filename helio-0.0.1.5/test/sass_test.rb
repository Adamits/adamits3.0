require 'test_helper'
require 'shellwords'

class SassTest < Minitest::Test
  DUMMY_PATH = 'test/dummy_sass_only'

  def setup
    Dir.chdir DUMMY_PATH do
      %x[rm -rf .sass-cache/]
      %x[bundle]
    end
    css_path = File.join GEM_PATH, 'tmp/helio-sass-only.css'
    command  = "bundle exec ruby compile.rb #{Shellwords.escape css_path}"
    success  = Dir.chdir DUMMY_PATH do
      silence_stdout_if !ENV['VERBOSE'] do
        system(command)
      end
    end
    assert success, 'Sass-only compilation failed'
    @css = File.read(css_path)
  end
end
