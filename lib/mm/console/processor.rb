module MM
  module Console
    class Processor
      REGISTERED_COMMANDS = []
      
      class EmptyContext
        def push(tokens)
        end
        def to_s
          ''
        end
      end
      
      def self.register(command)
        REGISTERED_COMMANDS << command
      end
      
      def initialize(runtime)
        @runtime = runtime
        @runtime[:context] ||= EmptyContext.new
      end
      
      def parse(input)
        if command = REGISTERED_COMMANDS.find{|cmd| cmd.map?(input)}
          command.instance(input)
        else
          ::MMLanguageParser.new.parse(input, @runtime)
        end
      end
      
      def process(input)
        mml = parse(input)
        mml.execute(@runtime)
      end
    end
  end
end
