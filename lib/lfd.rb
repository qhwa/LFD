# -*- encoding:utf-8
require 'yaml'

class LFD

  CONFIG_FILE = "asproj.info"
  MXMLC = ENV["MXMLC"]
  FLASH_PLAYER = ENV["FLASH_PLAYER"]

  def init(opt={})
    puts "creating new project #{opt}"
    base = opt[:proj]
    set_base(base) if base
    create_proj_files
    FileUtils.cd '..' if base
  end

  def build(opt={})
    puts "building #{opt}"
    unless File.exist?(CONFIG_FILE)
      puts "#{CONFIG_FILE} not found, exiting"
      exit 
    end
    info = YAML.load_file(CONFIG_FILE)
    ot = info["output"]
    args = [
      "--target-player=#{info["target"]}",
      "--output=#{ot["file"]}",
      "--source-path=#{array_opt_to_s info["source"]}",
      "--library-path=#{array_opt_to_s info["library"]}"
    ]
    w, h = ot["width"], ot["height"]
    args << "--default-size=#{w},#{h}" if w and h
    args << "--debug=true"
    # TODO: 加上更多的编译选项
    system MXMLC, info["main"], *args
  end

  def run(opt={})
    puts "running #{opt}"
    info = YAML.load_file(CONFIG_FILE)
    fork { exec FLASH_PLAYER, File.expand_path(info["output"]["file"],FileUtils.pwd) }
  end

  def rm(opt={})
    destory_proj
  end

  private
  def set_base(base)
    FileUtils.mkdir_p base
    FileUtils.cd base
  end

  def create_proj_files
    FileUtils.cp( File.expand_path("../#{CONFIG_FILE}.sample", __FILE__), CONFIG_FILE)
    FileUtils.mkdir %w(bin lib src tmp)
  end

  def destory_proj
    FileUtils.rm_f CONFIG_FILE
    FileUtils.rmdir %w(bin lib src tmp)
  end

  def array_opt_to_s(src)
    if Array === src
      src.join(',')
    else
      src.to_s
    end
  end

end
