require 'test/unit'
require 'fileutils'
require_relative '../lib/lfd'

FIXTURE_PATH = File.expand_path('fixture', File.dirname(__FILE__));

def cd(folder)
  FileUtils.cd folder
end

