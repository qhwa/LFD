require 'fileutils'
require 'lfd/env'
require 'lfd/setup'
require 'lfd/init'
require 'lfd/build'
require 'lfd/run'

module LFD

  CONFIG_FILE = 'asproj.info'

  class App

    include FileUtils

    ################################################
    # subcommand: env
    # 'env' also contains other helper methods
    include Env

    ###############################################
    # subcommand: setup
    include Setup

    ###############################################
    # subcommand: init
    include Init

    ###############################################
    # subcommand: build & release
    include Build

    ###############################################
    # subcommand: run
    include Run

    ###############################################
    # subcommand: test
    def test
      build && run
    end

    ###############################################
    # subcommand: clean
    def clean(opt={})
      rm_f CONFIG_FILE
      rmdir %w(bin lib src tmp)
    end

  end

end
