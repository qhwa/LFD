module LFD

  module Build

    # TODO: support building swc
    attr_reader :info

    def build(opt={})
      @options = opt
      if File.exist?(CONFIG_FILE)
        if mxmlc_ready?
          @info = YAML.load_file(CONFIG_FILE)
          if compile_to_swc?
            cmd = compc_path << " " << swc_build_arg.join( ' ' )
            puts cmd
            system cmd
          else
            system mxmlc_path, info["main"], *swf_build_arg
          end
        else
          fail "mxmlc not found!"
        end
      else
        fail "#{CONFIG_FILE} not found, exiting"
        exit 
      end
    end

    def release(opt={})
      build( opt.merge :debug => false )
    end

    private

      def compile_to_swc?
        output_path =~ /\.swc$/i
      end

      def output_path
        info["output"] && info["output"]["file"]
      end

      # swc compile options:
      #
      # -benchmark
      # -compiler.accessible
      # -compiler.actionscript-file-encoding <string>
      # -compiler.compress
      # -compiler.context-root <context-path>
      # -compiler.debug
      # -compiler.enable-runtime-design-layers
      # -compiler.extensions.extension [extension] [parameters] [...]
      # -compiler.external-library-path [path-element] [...]
      # -compiler.fonts.advanced-anti-aliasing
      # -compiler.fonts.flash-type
      # -compiler.fonts.max-glyphs-per-face <string>
      # -compiler.include-libraries [library] [...]
      # -compiler.incremental
      # -compiler.library-path [path-element] [...]
      # -compiler.locale [locale-element] [...]
      # -compiler.minimum-supported-version <string>
      # -compiler.mobile
      # -compiler.mxml.compatibility-version <version>
      # -compiler.mxml.minimum-supported-version <string>
      # -compiler.namespaces.namespace [uri] [manifest] [...]
      # -compiler.omit-trace-statements
      # -compiler.optimize
      # -compiler.preloader <string>
      # -compiler.report-invalid-styles-as-warnings
      # -compiler.services <filename>
      # -compiler.show-actionscript-warnings
      # -compiler.show-binding-warnings
      # -compiler.show-invalid-css-property-warnings
      # -compiler.show-shadowed-device-font-warnings
      # -compiler.show-unused-type-selector-warnings
      # -compiler.source-path [path-element] [...]
      # -compiler.strict
      # -compiler.theme [filename] [...]
      # -compiler.use-resource-bundle-metadata
      # -compiler.verbose-stacktraces
      # -compute-digest
      # -directory
      # -framework <string>
      # -help [keyword] [...]
      # -include-classes [class] [...]
      # -include-file <name> <path>
      # -include-namespaces [uri] [...]
      # -include-resource-bundles [bundle] [...]
      # -include-sources [path-element] [...]
      # -include-stylesheet <name> <path>
      # -licenses.license <product> <serial-number>
      # -load-config <filename>
      # -metadata.contributor <name>
      # -metadata.creator <name>
      # -metadata.date <text>
      # -metadata.description <text>
      # -metadata.language <code>
      # -metadata.localized-description <text> <lang>
      # -metadata.localized-title <title> <lang>
      # -metadata.publisher <name>
      # -metadata.title <text>
      # -output <filename>
      # -runtime-shared-libraries [url] [...]
      # -runtime-shared-library-path [path-element] [rsl-url] [policy-file-url] [rsl-url] [policy-file-url]
      # -static-link-runtime-shared-libraries
      # -swf-version <int>
      # -target-player <version>
      # -tools-locale <string>
      # -use-direct-blit
      # -use-gpu
      # -use-network
      # -version
      # -warnings
      def swc_build_arg
        [
          "-target-player #{info["target"]}",
          "-output #{output_path}",
          "-compiler.source-path #{array_opt_to_s info["source"], ' '}"
          # TODO: 加上更多的编译选项
        ].tap do |args|

          info["library"].tap do |libs|
            if libs
              args << "-compiler.library-path #{array_opt_to_s libs, ' '}"
            end
          end

          info["include_classes"].tap do |classes|
            if classes && !classes.empty?
              args << "-include-classes #{array_opt_to_s classes, ' '}"
            end
          end

        end
        
      end

      def debug?
        @options[:debug] != false
      end

      def swf_build_arg
        [
          "--target-player=#{info["target"]}",
          "--output=#{output_path}",
          "--source-path=#{array_opt_to_s info["source"]}",
          "--debug=#{@options[:debug] != false}",
          "-static-link-runtime-shared-libraries=true" 
          # TODO: 加上更多的编译选项
        ].tap do |args|

          info["library"].each do |lib|
            args << "--library-path+=#{lib}"
          end

          w, h = output["width"], output["height"]
          args << "--default-size=#{w},#{h}" if w and h

          # conditional compilation, set in asproj.info:
          #
          # compile_condition:
          #  CONFIG::debugging: true
          #
          cc = info["compile_condition"]
          cc && cc.each do |k, v|
            args << "-define+=#{k},#{v}"
          end

        end
      end

      def output
        info["output"]
      end

      def array_opt_to_s(src, sep = ',')
        case src
        when Array
          src.join sep
        else
          src.to_s
        end
      end


  end

end
