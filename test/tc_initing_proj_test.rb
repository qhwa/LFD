require_relative 'helper'

module LFDTest

  module Task

    class BuildingProjTest < Test::Unit::TestCase

      PROJ_DIR = 'tmp_proj'
      @@dir = File.dirname(File.expand_path __FILE__)

      def setup
        @lfd = LFD.new
        cd @@dir
      end

      def teardown
        cd @@dir
        FileUtils.rm_rf PROJ_DIR
      end

      def test_create_new_project_without_options
        FileUtils.mkdir_p PROJ_DIR
        cd PROJ_DIR

        @lfd.init 
        assert_proj_struct

      end

      private
      def cd(folder)
        FileUtils.cd folder
      end

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
