require 'test/unit'
require 'fileutils'
require 'yaml'
require_relative '../lib/lfd'

module LFDTest

  class TestCase < Test::Unit::TestCase

    include FileUtils

    attr_reader :lfd

    def setup
      cd test_home_dir
      FileUtils.mkdir_p proj_dir
      cd proj_dir

      @lfd = LFD.new
    end

    def teardown
      cd test_home_dir
      FileUtils.rm_rf proj_dir
    end

    def proj_dir
      File.join test_home_dir, 'tmp_proj'
    end

    def test_home_dir
      File.expand_path File.dirname(__FILE__)
    end

    def fixture_path
      File.join test_home_dir, 'fixture'
    end

  end

end
