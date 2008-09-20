module MM
  module Console
    class NoResourceCommand
      def initialize(command)
        @command = command
      end
      
      def execute(runtime)
        case
        when runtime[@command.to_sym]
          if runtime[@command.to_sym].is_a?(String) && mml = parse(runtime, runtime[@command.to_sym])
            mml.execute(runtime)
          else
            Console::SimpleCommand::RuntimeVariables::Value.new(@command.to_sym).execute(runtime)
          end
        else
          if @command && !@command.split.blank?
            which = runtime[:api].execute_cmd("which #{@command.split.first.inspect}")
            if which && which.first == 0
              runtime[:api].execute_cmd(@command)
            else
              raise "What's '#{@command}' mean?"
            end
          else
            #ignore empty command
          end
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
