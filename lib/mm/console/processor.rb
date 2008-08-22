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
      
      class HistoryEvent
        def initialize(event)
          @event = event
        end
        
        def execute(runtime)
          @event.apply(runtime)
        end
      end
      
      def self.register(command)
        REGISTERED_COMMANDS << command
      end
      
      def initialize(runtime)
        @runtime = runtime
        @runtime[:context] ||= EmptyContext.new
        @runtime[:history] ||= SelectingList.new([], HistoryEvent)
      end
      
      def parse(input)
        if command = REGISTERED_COMMANDS.find{|cmd| cmd.map?(input)}
          command.instance(input)
        else
          ::MMLanguageParser.new.parse(input, @runtime)
        end
      end
      
      def process(input)
        unless @runtime[:context].is_a?(EmptyContext)
          @runtime[:history] << @runtime[:context] 
          @runtime[:history].uniq!
        end
        mml = parse(input)
        mml.execute(@runtime)
      end
    end
  end
end
