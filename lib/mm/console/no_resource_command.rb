module MM
  module Console
    class NoResourceCommand
      def initialize(command)
        @command = command
      end
      
      def execute(runtime)
        case
        when runtime[@command.to_sym]
          MM::Console::Processor.new(runtime).process(runtime[@command.to_sym])
        else
          raise "What's '#{@command}' mean?"
        end
      end
    end
  end
end
