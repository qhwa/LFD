require_relative 'helper'
require 'yaml'

module LFDTest

  module Task

    class RunningProjTest < Test::Unit::TestCase

      PROJ_DIR = 'tmp_proj'

      def setup
        @lfd = LFD.new
      end

      def teardown
        FileUtils.rm_rf "bin/*.swf"
      end

      def test_building_flash10_proj
        cd "#{FIXTURE_PATH}/projects/flash10_proj"
        option = YAML.load_file('asproj.info')
        @lfd.build
        assert_equal 0, $?.exitstatus
        @lfd.run
        assert_equal 0, $?.exitstatus
      end

    end

  end
end
