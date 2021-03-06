require 'middleman-core'

module Middleman

  class CriticalExtension < Extension

    option :binary, 'critical', 'The critical binary to use'

    def initialize(app, options_hash={}, &block)
      super
    end

    def after_build(builder)

      rootPath = app.root
      buildDir = app.config[:build_dir]
      htmlDir = buildDir + File::SEPARATOR + '**' + File::SEPARATOR + '*.html'

      # cssDir = buildDir + File::SEPARATOR + app.config[:css_dir] + File::SEPARATOR + '**' + File::SEPARATOR + '*.css'
      #cssDirs = []

      #Dir.glob(cssDir) do |file|
      #  cssDirs.push(rootPath + File::SEPARATOR + file)
      #end

      Dir.glob(htmlDir) do |file|
        assetPath = rootPath + File::SEPARATOR + file
        %x(#{options.binary} #{assetPath} --base #{buildDir} --htmlTarget #{file} --extract --inline)
      end

    end

  end

end
