module MM
  module Console
    class NoResourceCommand
      def initialize(command)
        @command = command
      end
      
      def execute(runtime)
        case
        when runtime[@command.to_sym]
          if mml = parse(runtime, runtime[@command.to_sym])
            mml.execute(runtime)
          else
            runtime[@command.to_sym]
          end
        else
          raise "What's '#{@command}' mean?"
        end
      end

      def parse(runtime, script)
        processor(runtime).parse(script)
      rescue
      end
      
      def processor(runtime)
        MM::Console::Processor.new(runtime)
      end
    end
  end
end
