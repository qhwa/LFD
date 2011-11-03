# -*- encoding:utf-8
require 'yaml'

class LFD

  CONFIG_FILE = "asproj.info"
  MXMLC = ENV["MXMLC"]
  FLASH_PLAYER = ENV["FLASH_PLAYER"]
  TRACE_LOG = "#{ENV["HOME"]}/.macromedia/Flash_Player/Logs/flashlog.txt"
  CONFIG_SAMPLE = File.expand_path("../#{CONFIG_FILE}.sample", __FILE__)

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
      args = build_arg(info)
      system MXMLC, info["main"], *args
      raise "build_fail" if $?.exitstatus != 0
    else
      puts "#{CONFIG_FILE} not found, exiting"
      exit 
    end
  end

  def run(opt={})
    empty_tracelog
    info = YAML.load_file(CONFIG_FILE)
    swf = File.expand_path(info["output"]["file"], FileUtils.pwd) 
    player = fork { exec FLASH_PLAYER, swf}
    tracer = fork { exec "tail", "-f", TRACE_LOG }
    Process.detach tracer
    Process.wait
    Process.kill "HUP", tracer
  end

  def rm(opt={})
    FileUtils.rm_f CONFIG_FILE
    FileUtils.rmdir %w(bin lib src tmp)
  end

  private
  def install_flex_sdk
  end

  def install_flash_player
  end

  def empty_tracelog
    system "echo '' > #{TRACE_LOG}"
  end

  def build_arg(info)
    ot = info["output"]
    args = [
      "--target-player=#{info["target"]}",
      "--output=#{ot["file"]}",
      "--source-path=#{array_opt_to_s info["source"]}",
      "--debug=true",
      "-static-link-runtime-shared-libraries=true" 
      # TODO: 加上更多的编译选项
    ]
    info["library"].each { |lib| args << "--library-path+=#{lib}" }
    w, h = ot["width"], ot["height"]
    args << "--default-size=#{w},#{h}" if w and h
    args
  end

  def array_opt_to_s(src)
    if Array === src
      src.join(',')
    else
      src.to_s
    end
  end

end
