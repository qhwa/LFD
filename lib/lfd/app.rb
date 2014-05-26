require 'lfd/env'

module LFD

  class App

    CONFIG_FILE   = 'asproj.info'
    CONFIG_SAMPLE = File.expand_path("../../#{CONFIG_FILE}.sample", __FILE__)

    include Env

    ################################################
    ## subcommand: env

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

    ###############################################
    # subcommand: setup

    def setup(opt={})
      install_flex_sdk
      install_flash_player
    end

    def init(opt={})
      FileUtils.cp CONFIG_SAMPLE, CONFIG_FILE
      FileUtils.mkdir_p %w(bin lib src tmp)
    end

    def build(opt={})
      if File.exist?(CONFIG_FILE)
        info = YAML.load_file(CONFIG_FILE)
        args = build_arg(info, opt)
        if mxmlc_ready?
          p mxmlc_path
          system mxmlc_path, info["main"], *args
        else
          fail "mxmlc not found!"
        end
      else
        fail "#{CONFIG_FILE} not found, exiting"
        exit 
      end
    end

    def test
      build
      run
    end

    def release(opt=Hash.new)
      build :debug => false
    end

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

    def clean(opt={})
      FileUtils.rm_f CONFIG_FILE
      FileUtils.rmdir %w(bin lib src tmp)
    end

    private
    def install_flex_sdk
    end

    def install_flash_player
    end

    public
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

    def build_arg(info, opt={})
      ot = info["output"]
      [
        "--target-player=#{info["target"]}",
        "--output=#{ot["file"]}",
        "--source-path=#{array_opt_to_s info["source"]}",
        "--debug=#{opt[:debug] != false}",
        "-static-link-runtime-shared-libraries=true" 
        # TODO: 加上更多的编译选项
      ].tap do |args|

        info["library"].each do |lib|
          args << "--library-path+=#{lib}"
        end

        if include_classes = info["include_classes"]
          args << "-compiler.include-libraries #{include_classes.join ' '}"
        end

        w, h = ot["width"], ot["height"]
        args << "--default-size=#{w},#{h}" if w and h

      end
    end

    def array_opt_to_s(src)
      if Array === src
        src.join(',')
      else
        src.to_s
      end
    end

  end

end
