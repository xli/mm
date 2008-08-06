module MM
  module Console
    class Processor
      SIMPLE_COMMANDS = {}
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
        add(command[:key], command[:instance])
        if command[:short_key]
          add(command[:short_key], command[:instance])
        end
      end
      
      def self.add(key, instance)
        raise "Key #{key} has been registered by #{SIMPLE_COMMANDS[key].inspect}" if SIMPLE_COMMANDS[key]
        SIMPLE_COMMANDS[key] = instance
      end
      
      def initialize(runtime)
        @runtime = runtime
        @runtime[:context] ||= EmptyContext.new
      end
      
      def parse(input)
        SIMPLE_COMMANDS[input] || ::MMLanguageParser.new.parse(input, @runtime)
      end
      
      def process(input)
        mml = parse(input)
        mml.execute(@runtime)
      end
    end
  end
end
