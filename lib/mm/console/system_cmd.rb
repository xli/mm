module MM
  module Console
    class SystemCmd
      SCRIPT_REGEX = /\[([^\]]+)\]/
      
      def initialize(command)
        @command = command
      end
      
      def execute(runtime)
        @transition_script = if @command =~ SCRIPT_REGEX
          script = runtime[$1.to_sym] || $1
          cmd = parse(runtime, script)
          if cmd.is_a?(MM::Console::Transition)
            @command.gsub!(SCRIPT_REGEX, cmd.desc)
            script
          end
        end
        exitstatus, output = runtime[:api].execute_cmd(@command)
        if exitstatus == 0 && @transition_script
          if rev = output.to_s.split("\n").last.to_s.gsub(/[^0-9]/, '')
            runtime[:revision] = rev
          end
          processor(runtime).process(@transition_script)
        else
          output
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