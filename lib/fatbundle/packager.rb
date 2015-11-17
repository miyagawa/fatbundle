require 'bundler'
require 'pathname'

module Fatbundle
  class Packager
    def initialize
      @files = {}
    end
  
    def pack
      # assuming it's running under bundler already
      Bundler.load.specs.each do |spec|
        unless spec.extensions.empty?
          warn "Can't package C extension #{spec.name}"
          next
        end
          
        spec.load_paths.each do |path|
          warn "Packing #{spec.name} from #{spec.gem_dir}"
          collect(path)
        end
      end

      preamble = <<-EOF
        module Fatbundle
          FILES = #{@files.inspect}
          LOADED = []
        end

        module Kernel
          alias original_require require
          def require(file)
            if Fatbundle::LOADED.include?(file)
              return true
            end

            if Fatbundle::FILES[file]
              Fatbundle::LOADED << file
              return eval(Fatbundle::FILES[file], TOPLEVEL_BINDING)
            end

            warn "File '\#{file}' not found in Fatbundle, falling back to original require" if ENV['FATBUNDLE_DEBUG']
            original_require(file)
          end
        end
                   
      EOF

      puts preamble.gsub /^ {8}/, ''
    end

    def collect(path)
      base = Pathname.new(path)
      Dir["#{path}/**/*.rb"].each do |file|
        name = Pathname.new(file).relative_path_from(base)
        @files[name.sub(/\.rb$/, '').to_s] ||= File.read(file)
      end
    end
  end
end
