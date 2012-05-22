require_relative 'helper'

module LFDTest

  module Task

    class CheckMMCFGTest < Test::Unit::TestCase

      MM_CFG = "#{ENV["HOME"]}/mm.cfg"

      def setup
        @lfd = LFD.new
      end

      def teardown
      end

      def test_create_new_cfg_file_when_none
        FileUtils.rm_f MM_CFG
        @lfd.check_tracelog_config 
        
        assert File.exist?(MM_CFG)
        assert_right_config
      end

      def test_ajust_when_exist
        File.open(MM_CFG, 'w') do |file|
          file.puts "ErrorReportingEnable=0\nTraceOutputFileEnable=0\ntest=1"
        end
        @lfd.check_tracelog_config
        assert_equal "ErrorReportingEnable=1\nTraceOutputFileEnable=1\ntest=1\n", File.read(MM_CFG)
      end

      private
      def assert_right_config
        assert File.readlines(MM_CFG).any? { |line| line.chomp == "ErrorReportingEnable=1" }
        assert File.readlines(MM_CFG).any? { |line| line.chomp == "TraceOutputFileEnable=1" }
      end


    end

  end
end
