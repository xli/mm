module MM
  module Console
    module SimpleCommand
      class Open
        include Base

        def self.keys
          ['open( (.+))?']
        end

        def self.doc(runtime)
          "Open card, view or your context(card or view) in your default browser. This command sends 'open 'http:/project_url' to your Terminal, which may not work in Windows."
        end

        def initialize(input='')
          @input = input.gsub(/^open/, '').strip
        end

        def execute(runtime)
          unless @input.blank?
            resource = @input =~ /^#(\d+)$/ ? MM::Console::Card.new($1) : MM::Console::View.new(@input)
            resource.execute(runtime)
          end
          runtime[:context].open(runtime)
        end
      end
    end
  end
end