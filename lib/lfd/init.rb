require 'erb'

module LFD

  module Init

    include FileUtils

    Project = Struct.new(:name, :target)

    def init(opt={})
      mkdir_p %w(bin lib src tmp)
      mk_cfg
      mk_main
    end

    def mk_cfg
      render_template example_config_file, CONFIG_FILE
    end

    def example_config_file
      File.expand_path("../../../scaffold/asproj.info", __FILE__)
    end

    def render_template( src, dest )
      File.open( dest, 'w' ) do |file|
        file << ERB.new( File.read( src ) ).result( binding )
      end
    end

    def mk_main
      render_template example_main_file, main_file
    end

    def example_main_file
      File.expand_path("../../../scaffold/src/Main.as", __FILE__)
    end

    def main_file
      'src/Main.as'
    end

    alias_method :main, :main_file

    def project
      Project.new( project_name, '10.0' )
    end

    def project_name
      File.basename(pwd)
    end

  end

end
