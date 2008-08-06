module MM
  module Console
    class Processor
      class EmptyContext
        def push(tokens)
        end
        def to_s
          ''
        end
      end
      
      def initialize(runtime)
        @runtime = runtime
        @runtime[:context] ||= EmptyContext.new
        @simple_commands = {
          't' => MM::Console::Tabs.new,
          'tabs' => MM::Console::Tabs.new,
          'v' => MM::Console::RuntimeVariables.new,
          'variables' => MM::Console::RuntimeVariables.new,
          'clean_cache' => MM::Console::CleanCache.new
        }
      end
      
      def parse(input)
        @simple_commands[input] || ::MMLanguageParser.new.parse(input, @runtime)
      end
      
      def process(input)
        mml = parse(input)
        mml.execute(@runtime)
      end
    end
  end
end
