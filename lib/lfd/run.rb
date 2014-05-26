module LFD

  module Run

    def run(opt={})
      check_tracelog_config
      empty_tracelog
      info = YAML.load_file(CONFIG_FILE)
      swf = File.expand_path(info["output"]["file"], FileUtils.pwd) 
      player = fork { exec "#{flash_player_path} #{swf} 2> /dev/null"}
      tracer = fork { exec "tail", "-f", trace_log_file }
      Process.detach tracer
      Process.wait
      Process.kill "HUP", tracer
    end

    def check_tracelog_config
      if File.exist?(mm_cfg)
        File.open(mm_cfg, 'r+') do |file|
          cfg = {}
          file.each do |line|
            opt = line.split('=')
            cfg[opt[0]] = opt[1].chomp
          end
          cfg["ErrorReportingEnable"]="1"
          cfg["TraceOutputFileEnable"]="1"
          str = cfg.inject("") { |s,o| "#{s}#{o[0]}=#{o[1]}\n" }
          file.rewind
          file.write str
        end
      else
        File.open(mm_cfg, 'w') do |file|
          file.puts("ErrorReportingEnable=1\nTraceOutputFileEnable=1")
        end
      end
    end

    private

      def empty_tracelog
        system "echo '' > #{trace_log_file}"
      end

  end

end
