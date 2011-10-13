# -*- encoding:utf-8
require_relative 'lib/lfd.rb'

@lfd = LFD.new
PROXY = Proc.new { |t, arg| @lfd.send(t.name, arg) }

desc "在当前页面初始化as项目目录"
task :init, :proj, &PROXY

desc "编译项目"
task :build, :type, &PROXY

desc "打开编译后的.swf文件"
task :run, :target, &PROXY

desc "编译并打开.swf文件"
task :test => [:build, :run]

desc "删除项目文件"
task :rm, &PROXY

task :default => [:test]
