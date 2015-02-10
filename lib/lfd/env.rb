# encoding: utf-8
module LFD

  module Env
    
    # Public: Check the flash developing environment
    def env(opt={})
      check_flex_sdk
      check_flash_player
    end

    def check_flex_sdk
      check_cmd( "flex sdk - mxmlc", mxmlc_path )
      check_cmd( "flex sdk - compc", compc_path )
    end

    def check_cmd title, cmd_path
      print "#{title}: ".capitalize.rjust(20)
      if cmd_path
        puts cmd_path.chomp.green
      else
        puts "✗".red
      end
    end

    def check_flash_player
      check_cmd 'Flash Player', fp_path
    end

    def flex_sdk_ready?
      mxmlc_ready? && compc_ready?
    end

    def mxmlc_ready?
      executable? mxmlc
    end

    def executable? cmd
      !!executable_path( cmd )
    end

    def executable_path cmd
      path = IO.popen(['which', Shellwords.escape(cmd)], err: '/dev/null').read.chomp!
      path.presence
    end

    def compc_ready?
      executable? compc
    end

    def mxmlc
      ENV['MXMLC'] || 'mxmlc'
    end

    def mxmlc_path
      @mxmlc_path ||= executable_path( mxmlc )
    end

    def compc
      ENV['COMPC'] || 'compc'
    end

    def compc_path
      @compc_path ||= executable_path( compc )
    end

    def flash_player_ready?
      executable? flash_player
    end

    alias_method :fp_ready?, :flash_player_ready?

    def flash_player
      ENV['FLASH_PLAYER'] || 'flashplayer'
    end

    def flash_player_path
      @fp_path ||= executable_path( flash_player )
    end

    alias_method :fp_path, :flash_player_path

    def trace_log_file
      File.join ENV['HOME'], '.macromedia/Flash_Player/Logs/flashlog.txt'
    end

    def mm_cfg
      File.join ENV['HOME'], 'mm.cfg'
    end

  end

end
