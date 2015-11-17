require 'fatbundle/packager'

module Fatbundle
  class CLI
    def initialize(args)
      @script = args[0]
    end

    def run
      preamble = Fatbundle::Packager.new.pack
      puts preamble
      puts File.read(@script) if @script
    end
  end
end
