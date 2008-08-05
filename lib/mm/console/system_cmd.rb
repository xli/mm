module MM
  module Console
    class SystemCmd
      SCRIPT_REGEX = /\[([^\]]+)\]/
      
      def initialize(command)
        @command = command
      end
      
      def execute(runtime)
        @transition_injected = false
        if @command =~ SCRIPT_REGEX
          @inside_script = runtime[$1.to_sym] || $1
          cmd = processor(runtime).parse(@inside_script)
          if cmd.is_a?(MM::Console::Transition)
            @transition_injected = true
            @command.gsub!(SCRIPT_REGEX, cmd.desc)
          end
        end
        exitstatus, output = runtime[:api].execute_cmd(@command)
        if exitstatus == 0 && @transition_injected
          if rev = output.to_s.split("\n").last.to_s.gsub(/[^0-9]/, '')
            runtime[:revision] = rev
          end
          processor(runtime).process(@inside_script)
        else
          output
        end
      end
      
      def processor(runtime)
        MM::Console::Processor.new(runtime)
      end
    end
  end
end