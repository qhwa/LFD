require_relative 'helper'

module LFDTest

  module Task

    class BuildingProjTest < ::LFDTest::TestCase

      def test_building_flash10_proj
        cd "#{fixture_path}/projects/flash10_proj"
        option = YAML.load_file('asproj.info')
        @lfd.build
        assert_equal 0, $?.exitstatus, 'building should succeed'
        assert File.exist?( "#{option["output"]["file"]}" ), "binary file should have been made"
      end

    end

  end
end
