require_relative 'helper'

module LFDTest

  module Task

    class BuildingProjTest < ::LFDTest::TestCase

      def test_create_new_project_without_options
        @lfd.init 
        assert_proj_struct
      end

      private

        def assert_proj_struct
          assert File.exist?('asproj.info');
          assert File.directory?('src');
          assert File.directory?('lib');
          assert File.directory?('bin');
          assert File.directory?('tmp');
        end

    end

  end
end
