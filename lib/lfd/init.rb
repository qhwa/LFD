module LFD

  module Init

    include FileUtils

    def init(opt={})
      cp example_config_file, CONFIG_FILE
      mkdir_p %w(bin lib src tmp)
    end

    def example_config_file
      File.expand_path("../../asproj.info.sample", __FILE__)
    end

  end

end
