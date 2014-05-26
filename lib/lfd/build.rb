module LFD

  module Build

    # TODO: support building swc

    def build(opt={})
      if File.exist?(CONFIG_FILE)
        info = YAML.load_file(CONFIG_FILE)
        if mxmlc_ready?
          system mxmlc_path, info["main"], *build_arg(info, opt)
        else
          fail "mxmlc not found!"
        end
      else
        fail "#{CONFIG_FILE} not found, exiting"
        exit 
      end
    end

    def release(opt=Hash.new)
      build :debug => false
    end

    private

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
