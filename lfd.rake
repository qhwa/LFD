# -*- encoding:utf-8
require_relative 'lib/lfd.rb'

@lfd = LFD.new
PROXY = Proc.new { |t, arg| @lfd.send(t.name, arg) }
EXIT_ON_ERROR = Proc.new do |t, arg| 
  begin
    PROXY.call t, arg
  rescue => e
    exit
  end
end


desc "初始化Linux开发环境"
task :setup, &PROXY

desc "在当前页面初始化as项目目录"
task :init, :proj, &PROXY

desc "编译项目"
task :build, &EXIT_ON_ERROR

desc "发布项目（编译release版本）"
task :release, &EXIT_ON_ERROR

desc "打开编译后的.swf文件"
task :run, :target, &PROXY

desc "编译并打开.swf文件"
task :test => [:build, :run]

desc "删除项目文件"
task :rm, &PROXY

task :default => [:test]
