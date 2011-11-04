gem 'test-unit'
require 'test/unit'
require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner'

require_relative 'initing_proj_test'
require_relative 'building_proj_test'
require_relative 'running_proj_test'
require_relative 'check_mm_cfg_test'

module LFDTest

  class ALL < Test::Unit::TestSuite
    
    def self.suite
      tests = Test::Unit::TestSuite.new

      tests << LFDTest::Task::InitingProjTest.new
      tests << LFDTest::Task::BuildingProjTest.new
      tests << LFDTest::Task::RunningProjTest.new
      tests << LFDTest::Task::CheckMMCFGTest.new

      tests
    end
  end

end
