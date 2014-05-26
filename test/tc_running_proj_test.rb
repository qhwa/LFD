require_relative 'helper'

module LFDTest

  module Task

    class RunningProjTest < ::LFDTest::TestCase

      def test_building_flash10_proj
        cd "#{fixture_path}/projects/flash10_proj"
        option = YAML.load_file('asproj.info')

        @lfd.build
        assert_equal 0, $?.exitstatus

        @lfd.run
        assert_equal 0, $?.exitstatus
      end

    end

  end
end
